class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  enum :role, { user: 0, admin: 1 }, enums: true, default: :user

  has_many :billboard_interactions, dependent: :destroy
  has_many :billboards, through: :billboard_interactions
end
