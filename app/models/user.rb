class User < ActiveRecord::Base
    has_many :workouts
    has_secure_password

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :username, presence: true, uniqueness: true 
end
