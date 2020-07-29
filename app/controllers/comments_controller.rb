class CommentsController < ApplicationController
  http_basic_authenticate_with name: 'dhh', password: 'secret',
  only: :destroy

  def create
    @article = query_article
    @comment = @article.comments.create(comment_params)

    redirect_to article_path(@article)
  end

  def destroy
    @article = query_article
    @comment = @article.comments.find(params[:id])
    @comment.destroy

    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def query_article
    Article.find(params[:article_id])
  end
end