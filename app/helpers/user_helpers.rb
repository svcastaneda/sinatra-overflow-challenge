helpers do
  def current_user
    return nil if session[:user_id] == nil
    User.find(session[:user_id])
  end
  
  def author(object)
    object.user.username
  end
end
