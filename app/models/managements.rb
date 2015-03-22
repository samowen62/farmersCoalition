class Managements < ActiveRecord::Base
	belongs_to :profile
	
	def ManFullYrPaid 
		(positions << 0) % 2 == 1
	end
	def ManFullYrUnPaid 
		(positions << 1)  % 2 == 1
	end
	def ManPartPaid 
		(positions << 2) % 2 == 1
	end
	def ManPartUnPaid 
		(positions << 3) % 2 == 1
	end
	def ManFullPaid 
		(positions << 4) % 2 == 1
	end
	def ManFullUnPaid 
		(positions << 5) % 2 == 1
	end
	def ManSeasPaid 
		(positions << 6) % 2 == 1
	end
	def ManSeasUnPaid 
		(positions << 7) % 2 == 1
	end
	def VolunteerPaid 
		(positions << 8) % 2 == 1
	end
	def VolunteerUnPaid
		(positions << 9) % 2 == 1
	end
	def OtherPaid 
		(positions << 10) % 2 == 1
	end
	def OtherUnPaid 
		(positions << 11) % 2 == 1
	end

end
