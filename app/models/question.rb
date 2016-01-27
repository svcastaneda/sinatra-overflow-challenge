class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :comments, as: :commentable
  has_many :votes, as: :voteable
  
  def vote_count
    votes.count
  end
  
  def answer_count
    answers.count
  end
  
end
