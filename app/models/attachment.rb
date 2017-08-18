class Attachment
  include Mongoid::Document
  # field :name, type: String
  field :photo
  mount_uploader :photo, ImageUploader
  belongs_to :post
end
