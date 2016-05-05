class SessionsController < ApplicationController
  def new
  end
  
  def create
    nonprofit = Nonprofit.find_by(name: params[:nonprofit][:name].downcase)
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user, nonprofit.name
        params[:session][:remember_me] == '1' ? remember(user, nonprofit.name) : forget(user)
       # puts "Sessionscontroller#create====================="
        redirect_back_or user, :nonprofit_name => nonprofit.name
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
