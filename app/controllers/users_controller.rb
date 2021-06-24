class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET /users
  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  # GET /users/1
  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to testApp #{@user.username}, you have successfully signed up."
      redirect_to articles_path
    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end


  # DELETE /users/1
  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:notice] = "Account and all associated articles successfully deleted"
    redirect_to articles_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
      if current_user != @user
        flash[:alert] = "You can only edit or delete your own account"
        redirect_to @user
      end
    end
end
