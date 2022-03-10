class ArticlesController < ApplicationController
    def show
        # igual a article = article.find(1) en console
        @article = Article.find(params[:id])
    end
    
    def index
        @articles = Article.all
    end

    def new
    #   se crea esta instancia porque en new.html se renderiza en caso de errores en el def create, pero cuando se entra por primera vez
    # si no definimos esto, no sabra a que @article se refiere, ya que el @article se crea al momento de dar submit
      @article = Article.new
    end
    
    def edit
      # con el byebug en nuestra terminal escribimos params y nos dara los parametros de la ruta donde estemos
      # automaticamente se rellenara el formulario porque como intuye que es el edit.html con el metodo edit pues rails te trae los articles 
      @article = Article.find(params[:id])
    end
    
    def create
        # esto es para renderizar lo que cree al momento de dar submit
        # render plain: params[:article]
        # @article = Article.new(params.require(:article).permit(:title, :description)) con esto le metetemos los datos que creamos
        # @article.save
        # render plain: @article.inspect
        # redirect_to article_path(@article) esta es una manera mas larga de escribirlo

        @article = Article.new(params.require(:article).permit(:title, :description))
        if @article.save
          flash[:notice] = "El articulo se creo correctamente."
          redirect_to @article
        else 
          render 'new'
        end
    end
    
    def update
      @article = Article.find(params[:id])
      if @article.update(params.require(:article).permit(:title, :description)) #se agrega una whitelist como en create,esto linea  es =article.save 
        flash[:notice] = "El articulo se edito correctamente."
        redirect_to @article
      else
        render 'edit'
      end
    end

end
