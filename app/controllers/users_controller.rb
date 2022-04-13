class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]


  def new
    @user = User.new
  end

  def show
   
    @articles = @user.articles.paginate(page: params[:page], per_page: 4)
  end
  
  def index
    # @users = User.all
    @users = User.paginate(page: params[:page], per_page: 4)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Bienvenido a Alpha Blog #{@user.username}, te has registrado correctamente"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    
    if @user.update(user_params)
      flash[:notice] = "Tu informacion ha sido actualizada"
      redirect_to @user
    else
      render 'edit'
    end
  end
  

  private
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end