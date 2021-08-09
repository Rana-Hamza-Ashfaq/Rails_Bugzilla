class Project < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :bugs, dependent: :destroy
  validates :title, presence: true
  #:restrict_with_exception
end
