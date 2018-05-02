class JobsController < ApplicationController
	before_action :authenticate_developer!, only: [:new, :create, :edit, :update, :destroy]

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

		@applications = JobApplication.where(:job => @job.id)
		@applications.each do |application|
			@posts = Post.where(:application => application.id)
			@posts.each do |post|
				post.destroy
			end
			application.destroy
		end
	    @job.destroy
	    redirect_to "/"
	end

	def checkAppliedCheckbox
		# Create a new application and save it
		@application = JobApplication.new
		@application.job = params[:job]
	    @application.developer = current_developer.id
	    @application.save

	    @post = Post.new
	    @post.kind = 'Job Application'
	    @post.application = @application.id
	    @post.save

	    # Update his/her CV counter and save
	    current_developer.CV_counter = current_developer.CV_counter + 1
	    current_developer.points = current_developer.points + 1
	    	
    	current_developer.save

	end

	def uncheckAppliedCheckbox
		# Find the job application and post, delete them
		@application = JobApplication.where(:job => params[:job], :developer => current_developer.id).first
	    @post = Post.where(:kind => 'Job Application', :application => @application.id).first
	    
	    puts @post

	    @application.destroy
	    @post.destroy

	    # Update his/her CV counter and save it
	    current_developer.CV_counter = current_developer.CV_counter - 1
	    current_developer.points = current_developer.points - 1
	    	
    	current_developer.save

	end

	

	private

	def post_params
		params.require(:job).permit(:url, :title, :company)
	end

end
