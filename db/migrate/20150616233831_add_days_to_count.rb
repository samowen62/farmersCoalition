class AddDaysToCount < ActiveRecord::Migration
  def change
  	change_table :profiles do |p|
  		p.date	"day1"
  		p.date	"day2"
  		p.date	"day3"
  		p.date	"day4"
  	end
  end
end
