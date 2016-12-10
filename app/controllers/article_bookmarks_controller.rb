class ArticleBookmarksController < ApplicationController

  def create
    #find article
    @article = Article.new(article_params)
    @article.save # TODO add if error
    @article_bookmark = ArticleBookmark.new()
    @article_bookmark.user = current_user
    @article_bookmark.article = @article
    @article_bookmark.save
    redirect_to articles_path # remettre avec le mot recherché
  end

  def destroy
    #find article_bookmark
    @article_bookmark.destroy
    redirect_to articles_path # remettre avec le mot recherché
  end

  private
  def article_params
    params.require(:article).permit(:aylien_id, :source_url)
  end

end
