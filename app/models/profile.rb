class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :markets
  has_one :managements
end
