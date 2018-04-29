class WelcomeController < ApplicationController

  # GET /welcome
  def index
  	@developers = Developer.where.not(name: nil).sort_by(&:points).reverse.first(6)
  	@side_projects = SideProject.all.first(6)
  end

  def frontpage
  	@developers = Developer.where.not(name: nil).sort_by(&:points).reverse
  	@posts = Post.all.reverse
  end

  def chat
  	@developers = Developer.where.not(name: nil)
  	@posts = Post.all.reverse
  end

end
