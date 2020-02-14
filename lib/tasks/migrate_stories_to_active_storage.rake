# Regenerates the file names and places them in the proper file structure/hierarchy
# Copies files - old assets must be deleted manually

namespace :story do
  task migrate_stories_to_active_storage: :environment do
    Story.where.not(cover_file_name: nil).find_each do |story|
      # This step helps us catch any attachments we might have uploaded that
      # don't have an explicit file extension in the filename
      image = story.cover_file_name
      ext = File.extname(image)
      image_original = CGI.unescape(image.gsub(ext, "_original#{ext}"))

      # this url pattern can be changed to reflect whatever service you use - #{image_original} - sprintf converts '1' to '001'
      cover_url = "https://s3.amazonaws.com/#{ENV['S3_BUCKET_NAME']}/stories/covers/000/000/#{sprintf '%03d', story.id}/original/#{image}"
      story.cover.attach(io: open(cover_url),
                                  filename: story.cover_file_name,
                                  content_type: story.cover_content_type)
    end
  end
end