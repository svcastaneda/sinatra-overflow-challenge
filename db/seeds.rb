require 'faker'

50.times do
  User.create!(username: Faker::Internet.user_name, password_hash: "a")
end

50.times do
  Question.create!(user_id: rand(1..50), title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph)
end

25.times do
  Comment.create!(user_id: rand(1..50), body: Faker::Hacker.say_something_smart, commentable_id: rand(1..50), commentable_type: "Question")
end

25.times do
  Comment.create!(user_id: rand(1..50), body: Faker::Hacker.say_something_smart, commentable_id: rand(1..50), commentable_type: "Answer")
end

50.times do
  Answer.create!(user_id: rand(1..50), question_id: rand(1..50), body: Faker::Hacker.say_something_smart)
end

25.times do
  Vote.create!(user_id: rand(1..50), value: 1, voteable_id: rand(1..50), voteable_type: "Question")
end

25.times do
  Vote.create!(user_id: rand(1..50), value: 1, voteable_id: rand(1..50), voteable_type: "Answer")
end

25.times do
  Vote.create!(user_id: rand(1..50), value: -1, voteable_id: rand(1..50), voteable_type: "Question")
end

25.times do
  Vote.create!(user_id: rand(1..50), value: -1, voteable_id: rand(1..50), voteable_type: "Answer")
end
