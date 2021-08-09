class User < ApplicationRecord
  has_and_belongs_to_many :projects
  before_destroy do
    projects.each(&:destroy)
  end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :bugs, dependent: :destroy
end
