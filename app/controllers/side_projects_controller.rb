class SideProjectsController < ApplicationController
	before_action :authenticate_developer!, only: [:new, :create, :edit, :update, :destroy]

	def index
		@side_projects = SideProject.all.reverse
	end

	def new
		@side_project = SideProject.new
	end

	def create
	    @side_project = SideProject.new(post_params)
	    @side_project.developer_id = current_developer.id

	    if @side_project.save

	    	@post = Post.new
		    @post.kind = 'Side Project'
		    @post.side_project = @side_project.id
		    @post.save
	    
	    	current_developer.side_project_counter = current_developer.side_project_counter + 1
	    	current_developer.points = current_developer.points + 25

	    	current_developer.save

	   	  	redirect_to "/frontpage"
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
