class VisitorCount < ActiveRecord::Base
  belongs_to :profile

  has_many :entry_points
end
