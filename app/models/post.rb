class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::Validations

  validates :title, presence: true
  validates :content, presence: true

  field :title, type: String
  field :content, type: String
  # field :image
  # Before 'has_many' its 'embeds_many' have tested.
  # No way found to use 'embeds_many' with multiple ImageUploader instances.
  has_many :attachments

  # mount_uploader :image, ImageUploader
end
