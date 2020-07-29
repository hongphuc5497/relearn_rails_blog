class ArticlesController < ApplicationController
  http_basic_authenticate_with name: 'dhh', password: 'secret', except: [:index, :show]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
    @article = query_article
  end

  def edit
    @article = query_article
  end

  def update
    @article = query_article

    if @article.update(article_params)
      redirect_to @article
    else
      redner 'edit'
    end
  end

  def destroy
    @article = query_article
    @article.destroy

    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def query_article
    Article.find(params[:id])
  end
end
