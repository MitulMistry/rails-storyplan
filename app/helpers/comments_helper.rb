module CommentsHelper
  def readable_date(date_time)
    date_time.strftime("%A, %b %d, %Y")
  end
end
