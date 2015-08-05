class MarketsController < ApplicationController

	def create

	    profile = Profile.where(user_id: session[:user_id])

	    old = Market.where(profile_id: profile.id, market_type: params[:market_type], market_num: params[:market_num]).first

	    if old.nil?
		    market = Market.new(market_params)
		    market.save!
		    render plain: market.inspect
		    return
		else
			Market.update(params[:id], :end => params[:end], :start => params[:start])
			render plain: "success"
			return
		end

	end
	 
	  private
	    def market_params
	      params.permit(:start, :end, :market_type, :profile_id, :market_num)
	    end
end
