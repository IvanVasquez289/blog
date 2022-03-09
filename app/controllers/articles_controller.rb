class ArticlesController < ApplicationController
    def show
        # igual a article = article.find(1) en console
        @article = Article.find(params[:id])
    end
    
    
end
