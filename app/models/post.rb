class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :content, type: String

  # TODO
  # embeds_many :images, :class_name => 'Image'
  # accepts_nested_attributes_for :images, :allow_destroy => true


  mount_uploader :image, ImageUploader
  field :image
  # accepts_nested_attributes_for :image, :allow_destroy => true
end
