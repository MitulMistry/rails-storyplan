module WritersHelper
  def writer_truncated_bio(writer)
    truncate(writer.bio, length: 150, separator: /\s/) if writer.bio
  end

  def writer_card_avatar(writer)
    if writer.avatar.attached?
      image_tag writer.avatar.variant(resize: "400x400"), class: "card-img-top img-fluid"
    else
      image_tag "default/medium/default_user_avatar.png", class: "card-img-top img-fluid"
    end
  end

  def writer_image_avatar(writer)
    if writer.avatar.attached?
      image_tag writer.avatar.variant(resize: "400x400"), class: "img-fluid"
    else
      image_tag "default/medium/default_user_avatar.png", class: "img-fluid"
    end
  end
end
