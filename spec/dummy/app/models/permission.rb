class Permission < ApplicationRecord
  has_and_belongs_to_many :roles
  validates :controller, :action, presence: true
end
