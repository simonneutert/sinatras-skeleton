# frozen_string_literal: true

# The user class requires "BCrypt" to validate the encrypted password in the database.
class User < ActiveRecord::Base
  include BCrypt
  validates :username, uniqueness: true

  def authenticate?(attempted_password)
    BCrypt::Password.new(password) == attempted_password
  end
end
