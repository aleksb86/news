class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::Validations

  validates :title, presence: true
  validates :content, presence: true

  field :title, type: String
  field :content, type: String

  has_many :attachments, dependent: :destroy

end
