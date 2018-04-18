class JobsController < ApplicationController
	before_action :authenticate_developer!, only: [:new, :create, :edit, :update, :destroy]

	def index
		@jobs = Job.all
	end

	def index
		@jobs = Job.all
	end

	def new
		@job = Job.new
	end

	def create
	    @job = Job.new(post_params)
	    
	    if @job.save
	   	  	# Create a new post for the frontpage
		    @post = Post.new
		    @post.developer = current_developer.id
		    @post.body = current_developer.name + ' just applied for a new job: ' + post_params[:url]
		    @post.save

		    # Update his/her CV counter
		    current_developer.CV_counter = current_developer.CV_counter + 1
		    current_developer.save

		    # Set job to applied for user
		    application = Application.new
		    application.developer = current_developer.id
		    application.job = @job.id
		    
	   	  	redirect_to "/frontpage"
	    else
	      render 'new'
	    end
  	end

	def edit
		@job = Job.find(params[:id])
	end

	def update
    	@job = Job.find(params[:id])

    	if @job.update(post_params)
      		redirect_to "/"
    	else
      		render 'edit'
    	end
  	end

	def destroy
		@job = Job.find(params[:id])

	    @job.destroy
	    redirect_to "/"
	end

	

	private

	def post_params
		params.require(:job).permit(:url, :title, :company)
	end

end
