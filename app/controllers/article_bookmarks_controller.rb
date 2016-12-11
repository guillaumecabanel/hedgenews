class ArticleBookmarksController < ApplicationController

  def index
  end

  def create
    if Article.find_by_aylien_id(params[:article][:aylien_id])
      @article = Article.find_by_aylien_id(params[:article][:aylien_id])
    else
      @article = Article.create!(article_params)
    end
    # @article.save # TODO add if error
    @article_bookmark = ArticleBookmark.new()
    @article_bookmark.user = current_user
    @article_bookmark.article = @article
    @article_bookmark.save
    # redirect_to articles_path # remettre avec le mot recherché
  end

  def destroy
    #find article_bookmark
    @article = Article.find_by_aylien_id(params[:article][:aylien_id])
    @article_bookmark = current_user.article_bookmarks.find_by_article_id(@article.id)
    @article_bookmark.destroy
    #redirect_to articles_path # remettre avec le mot recherché
  end

  private
  def article_params
    params.require(:article).permit(:aylien_id, :source_url)
  end

end
