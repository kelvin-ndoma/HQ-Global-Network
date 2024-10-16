class User < ApplicationRecord
  # Use UUIDs for primary keys
  self.primary_key = 'id'

  # Secure password management
  has_secure_password

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: { in: ['normal_user', 'admin'] }, exclusion: { in: %w(admin) }, on: :create
  validates :status, allow_blank: true, length: { maximum: 255 }

  # Default role to 'normal_user'
  after_initialize :set_default_role, if: :new_record?

  # Enums for user roles
  enum role: { normal_user: 0, admin: 1 }

  # Associations (to be expanded)
  has_many :posts
  has_many :comments
  has_many :likes
  has_many :notifications
  has_many :follows
  has_many :groups, through: :user_groups
  has_many :events, through: :user_events
  has_many :forums, through: :user_forums
  has_many :cities, through: :user_cities

  # Validating email format with a regex pattern
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Optional: Handle user profile photo
  # If using Active Storage for image uploads, enable this:
  # has_one_attached :photo

  # Callbacks (optional)
  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end

  # Ensure all new users are 'normal_user' by default
  def set_default_role
    self.role ||= :normal_user
  end
end
