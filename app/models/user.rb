class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable
  include DeviseTokenAuth::Concerns::User

  has_many :posts

  def role_access_level
    return Role::ROLES[role] unless Role::ROLES[role].nil?
      
    Role::ROLES['Guest']
  end
end
