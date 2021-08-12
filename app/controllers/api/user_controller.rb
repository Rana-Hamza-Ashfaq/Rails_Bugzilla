class Api::UserController < ApplicationController
  def index
    @users = User.all
    respond_to do |format|
      format.json{ render :json => @users.to_json, :status => :ok }
    end
  end
end
