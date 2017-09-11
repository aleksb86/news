class User
  include Mongoid::Document
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  before_save :assign_role

  field :email, :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  validates_presence_of :email
  validates_presence_of :encrypted_password

  field :reset_password_token, :type => String
  field :reset_password_sent_at, :type => Time

  field :remember_created_at, :type => Time

  field :sign_in_count, :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at, :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip, :type => String

  field :name
  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  def assign_role
    self.role = Role.find_by(name: "Guest") if self.role.nil?
  end

  def admin?
    self.role.name == "Admin"
  end

  def writer?
    self.role.name == "Writer"
  end

  def guest?
    self.role.nil?
  end

  belongs_to :role
  has_many :posts
end
