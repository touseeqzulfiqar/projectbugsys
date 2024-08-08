class User < ApplicationRecord

  has_many :user_projects
  has_many :projects, through: :user_projects
  has_many : bugs
  enum role: { manager: 0, QA: 1, developer: 2 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
