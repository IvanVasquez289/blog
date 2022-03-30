class SessionsController < ApplicationController
  def new 

  end

  # cuando inicias sesion
  def create 
    user = User.find_by(email: params[:session][:email.downcase])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Iniciado sesion con exito"
      redirect_to user
    else
      flash.now[:alert] = "Hubo un error con tus credenciales"
      render 'new'
    end
  end

  # cuando cierras sesion se destruye la sesion
  def destroy 
    session[:user_id] = nil
    flash[:notice] = "Se ha cerrado la sesión"
    redirect_to root_path
  end
end