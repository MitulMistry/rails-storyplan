# Regenerates the file names and places them in the proper file structure/hierarchy
# Copies files - old assets must be deleted manually

namespace :user do
  task migrate_users_to_active_storage: :environment do
    User.where.not(avatar_file_name: nil).find_each do |user|
      # This step helps us catch any attachments we might have uploaded that
      # don't have an explicit file extension in the filename
      image = user.avatar_file_name
      ext = File.extname(image)
      image_original = CGI.unescape(image.gsub(ext, "_original#{ext}"))

      # this url pattern can be changed to reflect whatever service you use
      avatar_url = "https://s3.amazonaws.com/#{ENV['S3_BUCKET_NAME']}/users/#{user.id}/#{image_original}"
      user.avatar.attach(io: open(avatar_url),
                                    filename: user.avatar_file_name,
                                    content_type: user.avatar_content_type)
    end
  end
end