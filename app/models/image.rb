class Image
  include Mongoid::Document
  # attr_accessible :image
  field :image
  mount_uploader :image, ImageUploader
  # embedded_in :post
end
