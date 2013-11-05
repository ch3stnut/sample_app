class MicropostsController < ApplicationController
  before_filter :signed_in_only, only: [:create, :destroy]
  before_filter :correct_user_only, only: [:destroy]

  def index    
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Baleeted!"
    redirect_to root_url
  end

  private

    def correct_user_only
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_url if @micropost.nil?
    end

end