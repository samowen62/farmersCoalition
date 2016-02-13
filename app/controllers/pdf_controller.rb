Bundler.require "prawn"
Bundler.require 'prawn/measurement_extensions'
Bundler.require "prawn/table"

#useful links for developing this
#http://prawnpdf.org/manual.pdf
#http://prawnpdf.org/docs/0.11.1/Prawn/Document/BoundingBox.html
#https://fontlibrary.org/en

class PdfController < ApplicationController
	def title(pdf, position, text)
		pdf.font "app/assets/stylesheets/fonts/Hanken-Book.ttf"
		pdf.fill_color "60b560"
		pdf.draw_text(text, :size => 20, :at => position)
		pdf.fill_color "0b5b0b"
	end

	def infographic_prefs
		if user_is_logged_in?
			prefs = InfoGraphicPrefs.where(users_id: session[:user_id]).first

			if prefs.nil?
				new_prefs = InfoGraphicPrefs.create
				new_prefs[:users_id] = session[:user_id]
				new_prefs[:metrics] = params[:_json]
				new_prefs.save!
			else
	    		prefs[:metrics] = params[:_json]	
	    		prefs.save!	
			end
			render plain: session[:user_id]
		else 
    		redirect_to root_path
  		end
	end

	def gen_pdf
		prefs = InfoGraphicPrefs.where(users_id: session[:user_id]).first

		if prefs.nil?
			render plain: "nothing found"
			return
		end

		metric_prefs = prefs[:metrics]

		fonts = {
			"Hanken" => "app/assets/stylesheets/fonts/Hanken-Book.ttf",
			"Dancing" => "app/assets/stylesheets/fonts/DancingScript-Regular.ttf",
			"Dancing-bold" => "app/assets/stylesheets/fonts/DancingScript-Bold.ttf",
			"Railway" => "app/assets/stylesheets/fonts/Railway.ttf"
		}

		profile = Profile.where(user_id: session[:user_id]).first
		user_controller = ApplicationController::UsersController.new

		metrics = user_controller.metric_calc(profile)
		metric_data = user_controller.calc_metrics(metrics, profile)
		#render plain: metric_data
		#return

    	pdf = Prawn::Document.new

    	title(pdf, [40, 720], profile.name)

		img_market = "app/assets/images/FARMERS MARKET.jpg" 
    	pdf.image img_market, :at => [0,300], :width => 450  

    	#make into functions and pass blocks to gen specific content
    	#metric 1
    	if metric_prefs[0]
			pdf.bounding_box([0,700], :width => 250, :height => 120) do
				# This has the effect of creating a box of
				# padding 5 around the text
				pdf.stroke_bounds
				pdf.bounds.add_left_padding 5
				pdf.bounds.add_right_padding 5
				pdf.move_down 5

		    	pdf.text "Average number of visitors per market day"
		    	pdf.move_down 13

		    	pdf.indent (5) do
		    	 	pdf.text "#{profile[:day1]}: #{metric_data['1'][0][:count]}\n"
		    	end
		    	pdf.indent (5) do
		    	 	pdf.text "#{profile[:day2]}: #{metric_data['1'][1][:count]}\n"
		    	end
		    	pdf.indent (5) do
		    	 	pdf.text "#{profile[:day3]}: #{metric_data['1'][2][:count]}\n"
		    	end
		    	pdf.indent (5) do
		    	 	pdf.text "#{profile[:day4]}: #{metric_data['1'][3][:count]}\n"
		    	end

			end
		end

    	#metric 2
    	if metric_prefs[1]
			pdf.bounding_box([300,700], :width => 250, :height => 120) do
				# This has the effect of creating a box of
				# padding 5 around the text
				pdf.stroke_bounds
				pdf.bounds.add_left_padding 5
				pdf.bounds.add_right_padding 5
				pdf.move_down 5

		    	pdf.text "Total annual vendor sales at market"
		    	pdf.move_down 13

		    	pdf.indent (5) do
		    	 	pdf.text "Total sales: $#{if metric_data['2']['sales_slip'][0].total.nil? then 0.00 else metric_data['2']['sales_slip'][0].total end}\n"
		    	end
		    	pdf.indent (5) do
		    		pdf.text "Farm sales: $#{if metric_data['2']['sales_slip'][0].farm.nil? then 0.00 else metric_data['2']['sales_slip'][0].farm end}\n"
		    	end
		    	pdf.indent (5) do
		    		pdf.text "Value added sales: $#{if metric_data['2']['sales_slip'][0].value.nil? then 0.00 else metric_data['2']['sales_slip'][0].value end}\n"
		    	end
		    	pdf.indent (5) do
		    		pdf.text "Ready sales: $#{if metric_data['2']['sales_slip'][0].ready.nil? then 0.00 else metric_data['2']['sales_slip'][0].ready end}\n"
		    	end
			end
		end

		#metric 3
    	if metric_prefs[2]
			pdf.bounding_box([0,550], :width => 250, :height => 120) do
				# This has the effect of creating a box of
				# padding 5 around the text
				pdf.stroke_bounds
				pdf.bounds.add_left_padding 5
				pdf.bounds.add_right_padding 5
				pdf.move_down 5

		    	pdf.text "Average distance in miles traveled from product origin"
		    	pdf.move_down 13

		    	pdf.indent (5) do
		    	 	pdf.text "Primary Miles #{metric_data['3']['primary']}\n"
		    	end

		    	pdf.indent (5) do
		    	 	pdf.text "Secondary Miles #{metric_data['3']['secondary']}\n"
		    	end

			end
		end

		#metric 4
    	if metric_prefs[3]
			pdf.bounding_box([300,550], :width => 250, :height => 120) do

				pdf.stroke_bounds
				pdf.bounds.add_left_padding 5
				pdf.bounds.add_right_padding 5
				pdf.move_down 5

		    	pdf.text "Acres in agricultural production by market vendors"
		    	pdf.move_down 13

		    	pdf.indent (5) do
		    	 	pdf.text "Acres Owned: #{metric_data['4'][0].acres_owned}\n"
		    	end
		    	pdf.indent (5) do
		    	 	pdf.text "Acres Leased: #{metric_data['4'][0]['acres_leased']}\n"
		    	end
		    	pdf.indent (5) do
		    	 	pdf.text "Acres Cultivated: #{metric_data['4'][0]['acres_cultivated']}\n"
		    	end

			end
		end

		#Metric 12
=begin
		pdf.bounding_box([300,700], :width => 250, :height => 120) do
			
			pdf.stroke_bounds
			pdf.bounds.add_left_padding 5
			pdf.bounds.add_right_padding 5
			pdf.move_down 5

		    pdf.text "Percentage of farm vendors with less than 10 years farming experience."
		    pdf.move_down 13

		    avg = (metric_data['12']['1'] + metric_data['12']['2']) / 2 

		    pdf.indent (10) do
	    	 	pdf.text "#{avg}%\n", :size => 30
	    	end
		end
=end

		send_data pdf.render, type: "application/pdf", disposition: "inline"
		return

  	end
end
