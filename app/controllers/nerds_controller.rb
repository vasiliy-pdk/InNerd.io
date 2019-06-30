class NerdsController < ApplicationController
  def index
  end

  def search
    user_name = params[:user_name]
    if user_name.empty?
      flash[:notice] = 'Please enter GitHub username to the search field'
      redirect_to action: 'index'
    else
      redirect_to action: 'show', id: user_name
    end
  end

  def show
    user_name = params[:id]
    @nerd = Nerd.find(user_name)
  rescue NerdsDataSource::NotFound
    # @TODO: use `t` instead of the string, to reduce duplications
    flash[:notice] = "There is no GitHub account with name \"#{user_name}\". Please try to search using another username."
    redirect_to action: 'index'
  end
end
