class User < ActiveRecord::Base
  validates_presence_of  :zip
  validates :send_email, :send_text, inclusion: { in: [true, false] }
  validate :validate_zip
  validate :validate_phone_number

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.users_with_emails
    User.where(send_email: true)
  end

  private

  def validate_zip
    unless has_valid_zip?
      errors.add(:base, "Zip must be 5 digit number")
    end
  end

  def has_valid_zip?
    return false unless zip.class == String && zip.length == 5
    !!(zip.match(/\d\d\d\d\d/))
  end

  def validate_phone_number
    unless has_valid_phone_number?
      errors.add(:base, "Phone number isn't valid")
    end
  end

  def has_valid_phone_number?
    return true if phone_number.nil? || phone_number.strip == ""
    return false if !!(phone_number.match(/[a-z]|[A-Z]/))
    begin
      GlobalPhone.parse(phone_number).valid?
    rescue
      false
    end
  end
end
