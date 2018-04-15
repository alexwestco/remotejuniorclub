class ApplicationsController < ApplicationController

	def index
		@applications = Application.all
	end

	def new
		@application = Application.new
	end

	def create
	    @application = Application.new(post_params)

	    if @application.save
	   	  redirect_to "/"
	    else
	      render 'new'
	    end
  	end

	def edit
		@application = Application.find(params[:id])
	end

	def update
    	@application = Application.find(params[:id])

    	if @application.update(post_params)
      		redirect_to "/"
    	else
      		render 'edit'
    	end
  	end

	def destroy
		@application = Application.find(params[:id])

	    @application.destroy
	    redirect_to "/"
	end

	

	private

	def post_params
		params.require(:application).permit(:url)
	end

end
