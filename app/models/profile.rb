class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :markets
  has_one :managements
  has_one :accessibility
  has_one :community
  #yea I know, I was a retard and mispelled it
  has_one :visitor_survey

  has_many :vc_entrys
end
