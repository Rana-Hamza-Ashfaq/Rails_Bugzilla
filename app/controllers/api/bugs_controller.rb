class Api::BugsController < ApplicationController
  def index
    @bugs = Bug.all
    respond_to do |format|
      format.json{ render :json => @bugs.to_json, :status => :ok }
    end
  end
end
