class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:jwt_authenticatable,jwt_revocation_strategy: self

  has_and_belongs_to_many :roles

  def jwt_payload
    { 'message' => "This is just a dummy text" }
  end

  # This hook is executed when a token is dispatched for a user instance
  def on_jwt_dispatch(token, payload)
  end
end
