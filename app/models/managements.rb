class Managements < ActiveRecord::Base
	belongs_to :profile
	#after_initialize :default_values

    	def default_values 
    		#if :positions == 0
				self.ManFullYrPaid = :positions << 0
			#end
=begin  			self.ManFullYrUnPaid  = (:positions << 1)
  			self.ManPartPaid    = (:positions << 2)
  			self.ManPartUnPaid = (:positions << 3)
  			self.ManFullPaid  = (:positions << 4)
  			self.ManFullUnPaid    = (:positions << 5)
  			self.ManSeasPaid = (:positions << 6)
  			self.ManSeasUnPaid  = (:positions << 7)
  			self.VolunteerPaid  = (:positions << 8)
  			self.VolunteerUnPaid    = (:positions << 9)
  			self.OtherPaid = (:positions << 10)
  			self.OtherUnPaid  = (:positions << 11)
=end		
		end

	  #for i in 0..10 do puts "#{c >> i} and i is #{i}" end
end
