class InfoGraphicPrefs < ActiveRecord::Base
	self.table_name = "info_graphic_prefs"
	belongs_to :user
end

