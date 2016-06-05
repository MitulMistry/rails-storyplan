module WritersHelper
  def writer_truncated_bio(writer)
    truncate(writer.bio, length: 150, separator: /\s/) if writer.bio
  end
end
