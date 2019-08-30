class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy
  has_many :rsvps

  validates_presence_of :username, :email, :phone
  validates_uniqueness_of :username, :email

  def self.bulk_upload(file)
    require 'csv'
    users = []

    CSV.foreach(file.path, headers: true) do |row|
      users << build_user(username: row['username'],
                          email: row['email'],
                          phone: row['phone'],
                          password: row['password'])
    end

    User.import! users
  end

  private

  def self.build_user(username:, email:, phone:, password:)
    User.new(username: username,
             email: email,
             phone: phone,
             password: password)
  end
end
