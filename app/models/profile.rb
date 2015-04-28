class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :markets
  has_one :managements
  has_one :accessibility
  has_one :community

  has_many :visitor_survey
  has_many :sales_slip

  has_many :vc_entrys
end
