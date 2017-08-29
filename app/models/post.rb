class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::Validations
  include Mongoid::Elasticsearch

  attr_accessible :_type, :_id, :_index, :_score, :content, :title

  elasticsearch! index_mappings: {
    name: {
      type: 'multi_field',
      fields: {
        title: {type: 'string', boost: 10},
        content: {type: 'string', boost: 5},
        suggest: {type: 'completion'}
      }
    },
    desc: {type: 'string'},
  }

  validates :title, presence: true
  validates :content, presence: true

  field :title, type: String
  field :content, type: String

  has_many :attachments, dependent: :destroy

end
