class WelcomeController < ApplicationController

  # GET /welcome
  def index
  	@developers = Developer.all
  	@side_projects = SideProject.all
  end

end
