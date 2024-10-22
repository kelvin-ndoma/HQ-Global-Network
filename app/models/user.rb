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

  # Enums for user roles and status
  enum role: { normal_user: 0, admin: 1 }
  enum status: { offline: 0, active: 1 }

  # Default role and status to 'normal_user' and 'offline' respectively
  after_initialize :set_defaults, if: :new_record?

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

  # Optional: Handle user profile photo (Active Storage)
  # has_one_attached :photo

  # Callbacks (optional)
  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end

  # Ensure default role and status for new users
  def set_defaults
    self.role ||= :normal_user
    self.status ||= :offline
  end
end
