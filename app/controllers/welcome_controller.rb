class WelcomeController < ApplicationController

  # GET /welcome
  def index
  	@developers = Developer.where.not(name: nil).sort_by(&:points).reverse.first(6)
  	@side_projects = SideProject.all.first(6)
  end

  def frontpage
  	@developers = Developer.where.not(name: nil).sort_by(&:points).reverse.first(5)
  	@posts = Post.all.reverse.first(15)
  end

  def chat
  	
  end

end
