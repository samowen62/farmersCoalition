class AddFruitNutList < ActiveRecord::Migration
  def change
  	create_table :produce_list do |t|
      	t.references :visitor_application, index: true
      	t.integer	:year

      	t.boolean	:Artichokes
		t.boolean	:Arugula
		t.boolean	:Asparagus
		t.boolean	:Beans_green		#
		t.boolean	:Beans_dry			#
		t.boolean	:Beets
		t.boolean	:Beet_greens		#
		t.boolean	:Bok_choy			#
		t.boolean	:Broccoli
		t.boolean	:Broccoli_rabe		#
		t.boolean	:Brussels_sprouts	#
		t.boolean	:Cabbage_green		#
		t.boolean	:Cabbage_purple		#
		t.boolean	:Cardoons
		t.boolean	:Carrots
		t.boolean	:Cauliflower
		t.boolean	:Celeriac
		t.boolean	:Celery
		t.boolean	:Chard
		t.boolean	:Chicory
		t.boolean	:Chipilín
		t.boolean	:Collards
		t.boolean	:Corn_Sweet			#
		t.boolean	:Cress
		t.boolean	:Cucumbers
		t.boolean	:Dandelion_greens	#
		t.boolean	:Eggplant
		t.boolean	:Epazote
		t.boolean	:Fava_beans			#
		t.boolean	:Fennel
		t.boolean	:Garlic_bulb		#
		t.boolean	:Garlic_scapes		#
		t.boolean	:Herbs_fresh		#
		t.boolean	:Hierbamora
		t.boolean	:Horseradish
		t.boolean	:Jicama
		t.boolean	:Kale
		t.boolean	:Kohlrabi
		t.boolean	:Lambs_quarters		#
		t.boolean	:Leeks
		t.boolean	:Lettuce
		t.boolean	:Lima_beans			#
		t.boolean	:Mesclun_mixed_salad_greens		#
		t.boolean	:Mushrooms
		t.boolean	:Mustard_greens
		t.boolean	:Okra
		t.boolean	:Onions
		t.boolean	:Parsnips
		t.boolean	:Peas_english		#
		t.boolean	:Peas_sugar_snap	#
		t.boolean	:Peas_snow			#
		t.boolean	:Pea_shoots			#
		t.boolean	:Peppers_hot		#
		t.boolean	:Peppers_sweet_green#
		t.boolean	:Peppers_sweet_red	#
		t.boolean	:Peppers_sweet_purple	#
		t.boolean	:Peppers_sweet_yellow	#
		t.boolean	:Potatoes
		t.boolean	:Pumpkins
		t.boolean	:Purslane
		t.boolean	:Radishes 
		t.boolean	:Rhubarb
		t.boolean	:Rutabagas
		t.boolean	:Salsify
		t.boolean	:Scallions
		t.boolean	:Shallots
		t.boolean	:Spinach
		t.boolean	:Sprouts
		t.boolean	:Squash_aummer		#
		t.boolean	:Squash_winter		#
		t.boolean	:Sunchokes
		t.boolean	:Sweet_potatoes 	#
		t.boolean	:Sweet_potato_greens#
		t.boolean	:Tomatillos
		t.boolean	:Tomatoes
		t.boolean	:Turnips
		t.boolean	:Turnip_greens		#
		t.boolean	:Yacon

		t.boolean	:Apples
		t.boolean	:Apricots
		t.boolean	:Apriums
		t.boolean	:Asian_pears		#
		t.boolean	:Blackberries
		t.boolean	:Blueberries 
		t.boolean	:Boysenberries
		t.boolean	:Canary_melons		#
		t.boolean	:Cantaloupes
		t.boolean	:Cherimoyas
		t.boolean	:Cherries
		t.boolean	:Currants
		t.boolean	:Feijoas
		t.boolean	:Figs
		t.boolean	:Grapefruit
		t.boolean	:Grapes
		t.boolean	:Honeydew_melons	#	
		t.boolean	:Mulberries
		t.boolean	:PawPaws
		t.boolean	:Peaches
		t.boolean	:Pears
		t.boolean	:Plums
		t.boolean	:Quince
		t.boolean	:Raspberries_black 	#
		t.boolean	:Raspberries_red 	#
		t.boolean	:Strawberries
		t.boolean	:Tayberries
		t.boolean	:Watermelon
		t.boolean	:Wineberries

		t.boolean	:Chestnuts
		t.boolean	:Dates
		t.boolean	:Jujubes
		t.boolean	:Peanuts
		t.boolean	:Walnuts_black 	#
		t.boolean	:Walnuts_english 	#

    end
  end
end
