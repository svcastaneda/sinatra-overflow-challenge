get '/' do
  @questions = Question.order(created_at: :desc, id: :desc).limit(20)
  erb :index
end