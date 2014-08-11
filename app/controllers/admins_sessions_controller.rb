class AdminsSessionsController < ApplicationController

	def new
		if admin_signed_in?
			redirect_to admin_dashboard_path
		end
		@admin = Admin.new
	end

	def create
	  admin = Admin.find_by(name: params[:admins_session][:name].downcase)
	  if admin && admin.authenticate(params[:admins_session][:password])
	    admin_sign_in admin
	    redirect_to admin_dashboard_path
	  else
	    flash.now[:error] = 'Invalid email/password combination'
	    render 'new'
	  end
	end

	def destroy
	  admin_sign_out
	  redirect_to root_url
	end

	
end
