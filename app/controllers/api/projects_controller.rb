class Api::ProjectsController < ApplicationController
  def index
    @projects = Project.all
    respond_to do |format|
      format.json{render :json => @projects.to_json, :status => :ok}
    end
  end
end
