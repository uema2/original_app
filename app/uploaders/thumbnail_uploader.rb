class ThumbnailUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_fill: [400, 267]

  storage :file


  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  def size_range
    1..5.megabytes
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
