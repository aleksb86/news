class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::Validations
  include Mongoid::Elasticsearch

  elasticsearch!
  after_save :add_attachments

  # validates :title, presence: true
  # validates :content, presence: true

  field :title, type: String, presence: true
  field :content, type: String, presence: true

  has_many :attachments, dependent: :destroy
  belongs_to :user

  def add_attachments(attachments)
    this.attachments = attachments.map do |photo|
      attachment = Attachment.new(photo: photo, post_id: this.id)
      unless attachment.persisted?
        attachment.save
      end
      attachment
    end
    this.save!
    # attachments.first.persisted?
  end
end
