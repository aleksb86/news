class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::Validations
  include Mongoid::Elasticsearch

  elasticsearch!

  validates :title, :content, presence: true, uniqueness: true

  field :title, type: String
  field :content, type: String

  has_many :attachments, dependent: :destroy
  belongs_to :user

  def add_attachments(attachments)
    unless attachments.nil?
      self.attachments += attachments.map do |photo|
        attachment = Attachment.new(photo: photo, post_id: self.id)
        attachment.save!
        attachment
      end
    end
  end
end
