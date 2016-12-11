class ArticleBookmarksController < ApplicationController

  def index
    @articles_bookmarked = current_user.articles

    @selected_urls = []
    @hash_source_url = {}
    @articles_bookmarked.each do |article|
      @selected_urls << article.source_url
      @hash_source_url[Source.find(article.source_id).name] = article.source_url
    end
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
    params.require(:article).permit(:source_id, :title, :date, :abstract, :words_count, :time_to_read, :aylien_id, :source_url)
  end

end
