class DevelopersController < ApplicationController

	def index
		@developers = Developer.all
	end

	def new
		@developer = Developer.new
	end

	def create
	    @developer = Developer.new(post_params)

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

	def show
		@developer = Developer.find(params[:id])
	end

	private

	def post_params
		params.require(:developer).permit(:name, :bio, :personal_website, :profile_image)
	end

end
