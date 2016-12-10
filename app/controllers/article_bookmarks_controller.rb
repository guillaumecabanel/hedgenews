class ArticleBookmarksController < ApplicationController

  def create
    #find article
    #save article
    @article.save
    @article_bookmark = ArticleBookmark.new()
    @article_bookmark.user = current_user
    @article_bookmark.article =
    # save article bookmark
    @article_bookmark.save
  end

  def destroy
    #find article_bookmark
    @article_bookmark.destroy
  end

  def private

  end

end


def create
    @booking = Booking.new()
    @booking.user = current_user
    @booking.flat = @flat
    @flat.booked = true
    @flat.save
    @booking.status = "waiting"
    @booking.first_day_date = session[:current_search]["first_day_date"]
    @booking.last_day_date = session[:current_search]["last_day_date"]
    @booking.guests_count = session[:current_search]["guests_count"]
    @booking.price = price(@booking.first_day_date, @booking.last_day_date, @flat.price_per_night)
    @booking.save
    # raise
    redirect_to booking_path(@booking)
end
