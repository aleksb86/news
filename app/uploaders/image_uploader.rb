# encoding: utf-8

require 'carrierwave/processing/mini_magick'

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  storage :grid_fs

  def store_dir
    "public/uploads"
  end

  def default_url
    File.join(Rails.root, '/public/default.png')
  end

  version :thumb do
    process :resize_to_fit => [50, 50]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
