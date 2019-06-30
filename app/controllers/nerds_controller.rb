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
    @nerd = Nerd.find(params[:id])
  end
end
