# Be sure to restart your server when you modify this file.

# Ensure staging folder exists for uploading and processing images
stage_folder = "#{Rails.root}/public/image_previews"
unless Dir.exists?("#{stage_folder}")
  Dir.mkdir("#{stage_folder}",0700)
end
