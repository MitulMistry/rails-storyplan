# Regenerates the file names and places them in the proper file structure/hierarchy
# Copies files - old assets must be deleted manually

namespace :character do
  task migrate_characters_to_active_storage: :environment do
    Character.where.not(portrait_file_name: nil).find_each do |character|
      # This step helps us catch any attachments we might have uploaded that
      # don't have an explicit file extension in the filename
      image = character.portrait_file_name
      ext = File.extname(image)
      image_original = CGI.unescape(image.gsub(ext, "_original#{ext}"))

      # this url pattern can be changed to reflect whatever service you use - #{image_original} - sprintf converts '1' to '001'
      portrait_url = "https://#{ENV['S3_BUCKET_NAME']}.s3.amazonaws.com/characters/portraits/000/000/#{sprintf '%03d', character.id}/original/#{image}"
      character.portrait.attach(io: open(portrait_url),
                                  filename: character.portrait_file_name,
                                  content_type: character.portrait_content_type)
    end
  end
end