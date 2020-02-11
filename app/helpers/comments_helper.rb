module CommentsHelper
  def readable_date(date_time)
    date_time.strftime("%A, %b %d, %Y")
  end

  def comment_user_avatar(writer)
    if writer.avatar.attached?
      image_tag writer.avatar.variant(resize: "50x50"), class: "img-fluid rounded-circle"
    else
      image_tag "default/thumb/default_user_avatar.png", class: "img-fluid"
    end
  end
end
