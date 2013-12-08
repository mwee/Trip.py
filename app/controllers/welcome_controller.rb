class WelcomeController < ApplicationController

	def home 
		if current_user
			redirect_to user_show_path(current_user.id)  
		else
			render #home
		end
	end
	
end
