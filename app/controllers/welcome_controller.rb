class WelcomeController < ApplicationController

  # GET /welcome
  def index
  	@developers = Developer.all
  	@side_projects = SideProject.all.first(6)
  end

  def frontpage
  	@developers = Developer.all.sort_by(&:points).reverse
  	@posts = Post.all.reverse
  end

  def chat
  	@developers = Developer.all
  	@posts = Post.all.reverse
  end

end
