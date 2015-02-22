class SessionsController < ApplicationController
	
	def new	
	end

	def create
    	user = User.find_by username: params[:username]
    	if user && user.locked
    		redirect_to signin_path, :flash => { :error => 'Your account has been locked!' }
    	elsif user && user.authenticate(params[:password])
    		session[:user_id] = user.id
    		redirect_to user, notice: "Welcome back!"	
    	else
   			redirect_to :back, :flash => { :error => 'Username and/or password mismatch' }
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to :root
	end

end