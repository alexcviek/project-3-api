class User < ApplicationRecord
  has_secure_password validations: false


  has_and_belongs_to_many :trips_attending, class_name: "Trip", join_table: "trips_users"
  has_many :trips_created, class_name: "Trip", foreign_key: "user_id"

  mount_uploader :image, ImageUploader

  validates :username, presence: true, unless: :oauth_login?
  validates :email, uniqueness: true, presence: true, unless: :oauth_login?
  validates :password, presence: true, confirmation: true, unless: :oauth_login?, on: :create

  def oauth_login?
  facebook_id.present?
  end
end
