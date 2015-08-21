class ProduceList < ActiveRecord::Base
  self.table_name = "produce_list"
  belongs_to :visitor_application
end
