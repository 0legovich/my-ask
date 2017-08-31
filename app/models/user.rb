require 'openssl'

class User < ActiveRecord::Base
  #константы для работы метода шифрования пароля
  ITERATIONS = 2000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions

  validates :email, :username, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, on: :create
  validates :email, format: { with: /\A[a-zA-Z0-9_.\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-.]+\z/ }
  validates :username, length: { maximum: 40 }, format: { with: /\A[a-zA-z0-9_]+\z/ }

  attr_accessor :password

  before_save :encrypt_password

  def encrypt_password
    if self.password.present?
      #"соль" - рандомная строка усложняющая задачу хакерам
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      #хеш пароля - уникальная строка
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    #надодим пользователя с email-ом из базы
    user = find_by(email: email)

    if user.present? && user.password_hash ==
      User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
      user
    else
      nil
    end
  end
end
