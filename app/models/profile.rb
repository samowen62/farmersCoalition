class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :markets
  has_one :managements
  has_one :accessibility
  has_one :community
  
  has_many :visitor_application
  has_many :visitor_survey
  has_many :sales_slip
  has_many :entry_points
  has_many :food_assistance
  has_many :credit_sales
  has_many :misc_research
  has_many :market_program
end
