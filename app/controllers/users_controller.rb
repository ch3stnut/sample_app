class UsersController < ApplicationController
  before_filter :signed_in_only, only: [:edit, :update, :index, :destroy]
  before_filter :same_user_only, only: [:edit, :update]
  before_filter :signed_out_only, only: [:new, :create]
  before_filter :admin_user_only, only: [:destroy]
  before_filter :purple_palm_tree_protection, only: [:destroy] # reference to /s4s/
  
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the SampleApp, yo!"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "Your profile was updated, yo!"
      redirect_to @user
    else
      render :edit
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private

    def signed_in_only
      if !signed_in?
        store_location
        flash[:info] = "Please sign in to access this page."
        redirect_to signin_url
      end
    end

    def signed_out_only
      if signed_in?
        flash[:info] = "You are already signed in!"
        redirect_to root_url
      end
    end

    def same_user_only
      @user = User.find(params[:id])
      if !current_user?(@user)
        flash[:warning] = "Hey now, that's none of your business right there."
        redirect_to root_url
      end
    end

    def admin_user_only
      if !current_user.admin?
        flash[:danger] = "Nope, you can't go here. Sorry."
        redirect_to root_url
      end
    end

    def purple_palm_tree_protection
      if current_user.admin? && current_user == User.find(params[:id])
        flash[:danger] = "Look at what you have, Mr Admin! Why would you throw all that away?"
        redirect_to current_user
      end
    end

end
