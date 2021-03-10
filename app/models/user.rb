class User < ActiveRecord::Base

  has_many :reviews
  
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }
  before_save :downcase_email

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    if user && user.authenticate(password)
      return user
    else 
      return nil
    end
  end

  def downcase_email
    self.email.downcase!
 end
  
end
