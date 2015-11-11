class VisitorApplication < ActiveRecord::Base
  belongs_to :profile

  has_many	:produce_list
end
