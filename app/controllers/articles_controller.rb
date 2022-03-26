class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  def show
      # igual a article = article.find(1) en console
      
  end
  
  def index
      # @articles = Article.all
    @articles =Article.paginate(page: params[:page], per_page: 5)
  end

  def new
  #   se crea esta instancia porque en new.html se renderiza en caso de errores en el def create, pero cuando se entra por primera vez
  # si no definimos esto, no sabra a que @article se refiere, ya que el @article se crea al momento de dar submit
    @article = Article.new
  end
  
  def edit
    # con el byebug en nuestra terminal escribimos params y nos dara los parametros de la ruta donde estemos
    # automaticamente se rellenara el formulario porque como intuye que es el edit.html con el metodo edit pues rails te trae los articles 
  
  end
  
  def create
      # esto es para renderizar lo que cree al momento de dar submit
      # render plain: params[:article]
      # @article = Article.new(params.require(:article).permit(:title, :description)) con esto le metetemos los datos que creamos
      # @article.save
      # render plain: @article.inspect
      # redirect_to article_path(@article), es una manera mas larga de escribirlo, esto es el show, esto te manda a un article basado en id
      @article = Article.new(article_params)
      @article.user = User.first
      if @article.save
        flash[:notice] = "El articulo se creo correctamente."
        redirect_to @article
      else 
        render 'new'
      end
  end
  
  def update
    
    if @article.update(article_params) #se agrega una whitelist como en create,esto linea  es =article.save 
      flash[:notice] = "El articulo se edito correctamente."
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
  
    @article.destroy
    redirect_to articles_path
    # if @article.destroy
    #   flash[:success] = 'Object was successfully deleted.'
    #   redirect_to articles_path
    # else
    #   flash[:error] = 'Something went wrong'
    #   redirect_to articles_path
    # end
  end
  
  private
  
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
  
end
