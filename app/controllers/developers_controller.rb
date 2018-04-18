class DevelopersController < ApplicationController
	before_action :authenticate_developer!, only: [:new, :create, :edit, :update, :destroy]


	def index
		@developers = Developer.all
	end

	def new
		@developer = Developer.new
	end

	def create
	    @developer = Developer.new(post_params)
	    @developer.CV_counter = 0
	    if @developer.save
	   	  redirect_to "/"
	    else
	      render 'new'
	    end
  	end

	def edit
		@developer = Developer.find(params[:id])
	end

	def update
    	@developer = Developer.find(params[:id])

    	if @developer.update(post_params)
      		redirect_to "/"
    	else
      		render 'edit'
    	end
  	end

  	def profile
    	@developer = Developer.find(current_developer.id)
  	end

  	def edit_profile
		@developer = Developer.find(current_developer.id) 
	end

	def show_profile
		@developer = Developer.find(params[:id])
		@side_projects = SideProject.where(:developer_id => params[:id]).reverse
	end

	def destroy
		@developer = Developer.find(params[:id])

	    @developer.destroy
	    redirect_to "/"
	end

	

	private

	def post_params
		params.require(:developer).permit(:name, :bio, :personal_website, :profile_image)
	end

end
