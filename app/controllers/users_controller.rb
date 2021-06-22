class UsersController < ApplicationController


  # GET /users or /users.json


  # GET /users/1 or /users/1.json


  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit


  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to testApp #{@user.username}, you have successfully signed up."
      redirect_to articles_path
    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1 or /users/1.json


  # DELETE /users/1 or /users/1.json


  private
    # Use callbacks to share common setup or constraints between actions.


    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
