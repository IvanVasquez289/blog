class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_user , only:[:edit, :update] #requiere un user logeado pero aun nos permite editar los demas perfiles
  before_action :require_same_user, only: [:edit, :update, :destroy] #ya solo podemos editar el nuestro
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
  
  def destroy 
    @user.destroy
    if current_user == @user
    session[:user_id] = nil
    end 
    flash[:notice] = "La cuenta y sus articulos asociados han sido eliminados"
    redirect_to articles_path
  end
  
  private
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = 'Solo puedes editar o eliminar tu propio perfil'
      redirect_to @user
    end
  end
end