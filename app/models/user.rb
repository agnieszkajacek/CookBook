class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :favourites
  has_many :recipes, through: :favourites
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :github]


	def self.from_omniauth(auth)
	  user = where("(provider = ? and provider = ?) or email = ?", auth.provider, auth.uid, auth.info.email).first_or_initialize
	  user.email = auth.info.email
    if user.password.nil? 
      user.password = Devise.friendly_token[0,20] 
    end
    user.uid = auth.uid
    user.provider = auth.provider
    user.save
    user

  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end