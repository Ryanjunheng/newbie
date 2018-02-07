class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable 

  has_many :authentications 

  def self.create_with_auth_and_hash(authentication, auth_hash)
     user = self.create!(
      name: auth_hash["extra"]["raw_info"]["name"],
      email: auth_hash["extra"]["raw_info"]["email"],
      password: Device.friendly_token[0,10]
     )
     user.authentications << authentication
     return user
  end

  def fb_token
     x = self.authentications.find_by(provider: 'facebook')
     return x.token unless x.nil?
  end
end

