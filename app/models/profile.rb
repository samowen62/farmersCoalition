class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :markets
  validates :name, presence: true, length: { minimum: 2}
end
