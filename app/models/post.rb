class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::Validations
  include Mongoid::Elasticsearch

  # attr_accessible :_type, :_id, :_index, :_score, :content, :title

  elasticsearch!

  validates :title, presence: true
  validates :content, presence: true

  field :title, type: String
  field :content, type: String

  has_many :attachments, dependent: :destroy
  belongs_to :user

end
