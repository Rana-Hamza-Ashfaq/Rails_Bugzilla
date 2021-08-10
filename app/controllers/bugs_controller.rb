class BugsController < ApplicationController
  before_action :set_bug, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :developer?, only: %i[new edit update destroy]
  before_action :not_developer?, only: %i[index]

  # GET /bugs or /bugs.json
  def index
    @bugs = Bug.all
    project_id = params[:id]
    @project = Project.find_by(id: project_id)
  end

  # GET /bugs/1 or /bugs/1.json
  def show; end

  # GET /bugs/new
  def new
    @bug = Bug.new
    @project_id = params[:id]
  end

  # GET /bugs/1/edit
  def edit
    @project_id = params[:pid]
  end

  # POST /bugs or /bugs.json
  def create
    @bug = Bug.new(bug_params)
    @project_id = @bug.project_id
    @project = Project.find_by(id: @project_id)
    respond_to do |format|
      if @bug.due_date < Date.current
        format.html { redirect_to project_url(@project_id), notice: 'Due Date cannot be less than current Date' }
      elsif @bug.save
        format.html { redirect_to @bug, notice: 'Bug was successfully created.' }
        format.json { render :show, status: :created, location: @bug }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  rescue
    redirect_to project_url(:id => @project_id), notice: 'Error: Some constraints are not matching.'
  end

  # PATCH/PUT /bugs/1 or /bugs/1.json
  def update
    respond_to do |format|
      if @bug.update(bug_params)
        if params.key?(:image)
          @bug.image.purge_later
          @bug.image.attach(params[:bug][:image])
        end
        format.html { redirect_to @bug, notice: 'Bug was successfully updated.' }
        format.json { render :show, status: :ok, location: @bug }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bugs/1 or /bugs/1.json
  def destroy
    project_id = @bug.project_id
    @bug.image.purge
    @bug.destroy
    respond_to do |format|
      format.html { redirect_to bugs_url(id: project_id), notice: 'Bug was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def not_developer?
    if params[:id].blank?
      redirect_to root_url, notice: 'You cannot directly access that page without project ID.'
    end
  end

  def developer?
    return redirect_to root_url, notice: 'You cannot access this page.' if current_user.user_type == 'Developer'
  end
  # Use callbacks to share common setup or constraints between actions.

  def set_bug
    @bug = Bug.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def bug_params
    params.require(:bug).permit(:title, :description, :due_date, :bugtype, :status, :user_id, :project_id, :image)
  end
end
