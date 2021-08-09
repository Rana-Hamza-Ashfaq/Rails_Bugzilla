class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :not_developer?, only: %i[all_dev project_users]
  before_action :developer?, only: %i[list_assigned_bugs]
  def index; end

  def all_dev
    @project_id = params[:id]
    @user_type = params[:user_type]
  end

  def assign_project
    @project_id = params[:id]
    @user_id = params[:user_id]
    @project = Project.find_by(id: @project_id)
    @user = User.find_by(id: @user_id)
    if @project.user_ids.include?(@user.id)
      redirect_to proc { project_url(@project_id) }, notice: "Project is already Assigned to this #{@user.user_type}."
    else
      @project.users << @user
      redirect_to proc { project_url(@project_id) }, notice: "Project is Assigned to #{@user.user_type}."
    end
  end

  def project_users
    @project_id = params[:id]
    @user_type = params[:user_type]
    @project = Project.find_by(id: @project_id)
  end

  def remove_project_user
    project_id = params[:id]
    user_id = params[:user_id]
    user = User.find_by(id: user_id)
    project = Project.find_by(id: project_id)
    project.user_ids = project.user_ids - [user.id]
    redirect_to proc { project_url(project_id) }, notice: "#{user.firstname} is removed from Project."
  end

  def take_bug
    bug_id = params[:id]
    @bug = Bug.find_by(id: bug_id)
    @bug.update(status: 'Started', assign_id: current_user.id)
    redirect_to proc { project_url(@bug.project_id) }, notice: 'Bug is Assigned to Developer.'
  end

  def list_assigned_bugs; end

  def complete_bug
    bug_id = params[:id]
    @bug = Bug.find_by(id: bug_id)
    @bug.update(status: 'Completed')
    redirect_to projects_url, notice: 'Assigned Bug is completed.'
  end

  private

  def not_developer?
    if current_user.user_type == 'Developer'
      redirect_to root_url, notice: 'You cannot access that page.'
    elsif params[:id].blank? && params[:user_type].blank?
      redirect_to root_url, notice: 'You cannot directly access that page without ID\'s.'
    end
  end

  def developer?
    redirect_to root_url, notice: 'You cannot access that page.' if current_user.user_type != 'Developer'
  end
end
