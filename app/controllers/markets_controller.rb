class MarketsController < ApplicationController

	def create

	    profile = Profile.find(params[:profile_id])
	    unless profile.user_id == session[:user_id]
	    	render plain: "Nice try sucker"
	    	return
	    end

	    market = Market.new(market_params)
	    market.save!
	    render plain: market.inspect
	    return
	end
	 
	  private
	    def market_params
	      params.permit(:start, :end, :market_type, :profile_id, :market_num)
	    end
end
