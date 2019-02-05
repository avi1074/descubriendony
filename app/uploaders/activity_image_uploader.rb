# encoding: utf-8

class ActivityImageUploader < CarrierWave::Uploader::Base
# include CarrierWaveDirect::Uploader
  include CarrierWave::MiniMagick
  
  # include ActiveModel::Conversion
  # extend ActiveModel::Naming

  include CarrierWave::MimeTypes
  process :set_content_type

  storage :fog

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb, :if => :image? do
    process :efficient_conversion => [90, 55]
  end

  version :small, :if => :image? do
    process :efficient_conversion => [180, 110]
  end

  version :medium, :if => :image? do
    process :efficient_conversion => [468, 286]
  end

  version :large, :if => :image? do
    process :efficient_conversion => [936, 572]
  end

  def efficient_conversion(width, height)
    # Resize to Fill manipulation
    manipulate! do |img|
      cols, rows = img[:dimensions]
      img.combine_options do |cmd|
        if width != cols || height != rows
          scale = [width/cols.to_f, height/rows.to_f].max
          cols = (scale * (cols + 0.5)).round
          rows = (scale * (rows + 0.5)).round
          cmd.resize "#{cols}x#{rows}"
        end
        cmd.gravity 'Center'
        cmd.background "rgba(255,255,255,0.0)"
        cmd.extent "#{width}x#{height}" if cols != width || rows != height
      end
      img = yield(img) if block_given?
      img.flatten
      img.quality('80')
      img.format('jpg')
      img
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png bmp)
  end

  protected

  def image?(new_file)
    new_file.content_type.include? 'image'
  end

end
