class SideProjectsController < ApplicationController
	def index
		@side_projects = SideProject.all
	end

	def new
		@side_project = SideProject.new
	end

	def create
	    @side_project = SideProject.new(post_params)
	    @side_project.developer_id = current_developer.id

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

	def edit_side_projects
		@side_projects = SideProject.where(:developer_id => current_developer.id).reverse
	end

	private

	def post_params
		params.require(:side_project).permit(:name, :description, :github_repo, :website, :image, :tech_stack)
	end


end
