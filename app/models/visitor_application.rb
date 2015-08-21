class VisitorApplication < ActiveRecord::Base
  belongs_to :profile

  has_one	:produce_list
end
