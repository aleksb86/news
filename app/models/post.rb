class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :content, type: String
  field :image
  # TODO
  # embeds_many :images, :class_name => 'Image'
  # accepts_nested_attributes_for :images, :allow_destroy => true


  mount_uploader :image, ImageUploader

  # accepts_nested_attributes_for :image, :allow_destroy => true
end
