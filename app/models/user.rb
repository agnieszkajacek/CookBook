class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :favourites
  has_many :providers
  has_many :recipes, through: :favourites
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :github, :google_oauth2]


	def self.from_omniauth(auth)
    
    provider = Provider.where(uid: auth.uid, name: auth.provider).first
    
    if provider 
      user = provider.user
    else 
      user = User.where(email: auth.info.email).first_or_initialize
    end

    if not user.persisted?
      user.password = Devise.friendly_token[0,20] 
      user.email = auth.info.email
    end

    user.save!

    Provider.find_or_create_by(uid: auth.uid, name: auth.provider, user: user)
    user
  end
end