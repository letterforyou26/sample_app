class User < ApplicationRecord
  before_save :downcase_email

  validates :email, presence: true,
    length: {
      minium: Settings.validate.email.min_length,
      maximum: Settings.validate.email.max_length
    },
    format: {with: Settings.validate.email.regex},
    uniqueness: {
      case_sensitive: Settings.validate.email.case_sensitive
    }

  validates :name, presence: true, length: {
    maximum: Settings.validate.name.max_length
  }

  validates :password, presence: true, length: {
    minimum: Settings.validate.password.min_length
  },
    if: :password

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
