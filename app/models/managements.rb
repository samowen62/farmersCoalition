class Managements < ActiveRecord::Base
	belongs_to :profile
	
	def pos(bit)
		(positions >> bit) % 2 == 1
	end

end
