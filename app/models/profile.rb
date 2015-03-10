class Profile < ActiveRecord::Base
  belongs_to :users
  validates :name, presence: true, length: { minimum: 2}
end
