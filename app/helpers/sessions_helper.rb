module SessionsHelper
	
  #Logs in the given user
  def log_in(user, nonprofit)
  	#  puts "********** npname=" + nonprofit
    session[:user_id] = user.id
    session[:nonprofit] = nonprofit
  end
  
  def remember(user, nonprofit)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
    cookies.permanent[:nonprofit] = "dancers workshop"
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def current_user
    if (user_id = session[:user_id])      # <-- assignment of value *to* user_id
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])  # <- comes from cookie via 'remember'
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user, cookies[:nonprofit]
        @current_user = user
      end
    end
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user=nil
  end
  
  def redirect_back_or(default, nonprofit)
    if session[:forwarding_url].nil? then
      path = user_path(default)
    	   # puts "redirect_back: path=" + path
      redirect_to path
    else
    	   # puts "redirect_back: else path"
      redirect_to(session[:forwarding_url])
    end

    session.delete(:forwarding_url)
  end
  
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
  
end
