get '/login'  do
    erb :'users/login'
end

post '/login' do
  user = User.find_by(username: params[:username])
  if user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/'
  else
    erb :'users/login'
  end
end

get '/users/new' do
  erb :'users/new'
end

post '/users/new' do
  @user = User.new(params[:new_account])
  if @user.save
    session[:user_id] = @user.id
    redirect '/'
  else
    @errors = @user.errors.full_messages
    erb :'users/create_account'
  end
end

get '/users/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/users/:username' do
  @user = User.find_by(username: params[:username])
  erb :'users/show'
end

# delete '/users/logout' do
#   session[:user_id] = nil
#   redirect '/'
# end
