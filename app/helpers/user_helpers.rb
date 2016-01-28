helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end
  
  def author(object)
    object.user.username
  end
end
