get '/users/login'  do
    erb :'users/login'
end

post '/users' do
  user = User.find_by(username: params[:username])
  if user.authenticate(params[:password])
    session[:id] = user.id
    redirect '/'
  else
    erb :'users/login'
  end
end

get '/users/new' do
  erb :'users/create_account'
end

post '/users' do
  @user = User.new(params[:new_account])
  if @user.save
    session[:id] = @user.id
    redirect '/'
  else
    @errors = @user.errors.full_messages
    erb :'users/create_account'
  end
end

get '/users/logout' do
  session[:id] = nil
  redirect '/'
end
