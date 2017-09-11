class Attachment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :photo
  mount_uploader :photo, ImageUploader
  belongs_to :post
end
