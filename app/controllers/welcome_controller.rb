class WelcomeController < ApplicationController

  # GET /welcome
  def index
  	@developers = Developer.all
  end

end
