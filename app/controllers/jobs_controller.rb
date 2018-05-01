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
	    @job.creator = current_developer.id
	    
	    if @job.save
	   	  	# Create a new post for the frontpage
		    @post = Post.new
		    @post.kind = 'Job Application'

		    @application = JobApplication.new
		    @application.job = @job.id
		    @application.developer = current_developer.id
		    @application.save

		    @post.application = @application.id
		    @post.save

		    # Update his/her CV counter
		    current_developer.CV_counter = current_developer.CV_counter + 1
		    current_developer.points = current_developer.points + 1
	    	
	    	current_developer.save
		    
	   	  	redirect_to "/frontpage"
	    else
	      render 'new'
	    end
  	end

	def edit
		@job = Job.find(params[:id])
		if current_developer.id != @job.creator
			redirect_to "/frontpage"
		end
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
