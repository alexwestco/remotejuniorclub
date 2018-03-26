class SideProjectsController < ApplicationController
	def index
		@side_projects = SideProject.all
	end

	def new
		@side_project = SideProject.new
	end

	def create
	    @side_project = SideProject.new(post_params)

	    if @side_project.save
	   	  redirect_to "/"
	    else
	      render 'new'
	    end
  	end

	def edit
		@side_project = SideProject.find(params[:id])
	end

	def update
    	@side_project = SideProject.find(params[:id])

    	if @side_project.update(post_params)
      		redirect_to "/"
    	else
      		render 'edit'
    	end
  	end

	def show
		@side_project = SideProject.find(params[:id])
	end

	def destroy
		@side_project = SideProject.find(params[:id])

	    @side_project.destroy
	    redirect_to "/"
	end

	private

	def post_params
		params.require(:side_project).permit(:name, :description, :github_repo, :website, :pimage)
	end


end
