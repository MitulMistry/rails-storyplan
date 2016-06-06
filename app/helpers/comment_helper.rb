module CommentHelper
  def readable_date_time(item)
    item.created_at.strftime("%A, %b %d, %Y")
  end
end
