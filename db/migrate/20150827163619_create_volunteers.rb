class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|   
    	t.references :profile, index: true
    	t.date		:service_date
    	t.string	:first
    	t.string	:last
    	t.integer	:people_committed
    	t.float		:hours_committed
    	
    	t.integer	:people_attended
    	t.time		:arrival
    	t.time		:departure
    	t.text		:completed_task
    end
  end
end
