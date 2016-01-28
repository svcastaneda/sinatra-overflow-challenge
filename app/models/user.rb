class User < ActiveRecord::Base
  include BCrypt

  has_many :questions
  has_many :comments
  has_many :votes
  has_many :answers

  validates :username, :password_hash, {presence: true}
  validates :username, {uniqueness: true}

  def password
    Password.new(password_hash)
  end

  def password=(password_plaintext)
    self.password_hash = Password.create(password_plaintext)
  end

  def self.authenticate(username, password_plaintext)
    user = User.find_by(username: username)
    return user if user && user.password == password_plaintext
  end
end
