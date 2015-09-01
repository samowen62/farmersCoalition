class AddColToVols < ActiveRecord::Migration
  def change
  	change_table :volunteers do |t|   
    	t.string	:assigned_task
    end
  end
end
