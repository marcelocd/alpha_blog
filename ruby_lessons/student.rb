require 'bcrypt'
require_relative 'crud'

class Student
	include Crud

	attr_accessor :first_name, :last_name, :username, :email, :password

	def initialize first_name, last_name, username, email, password
		@first_name = first_name
		@last_name  = last_name
		@username   = username
		@email      = email
		@password   = password
	end
	
	def to_s
		string  = "First name: #{@first_name}"
		string += "\nLast name: #{@last_name}"
		string += "\nUsername : #{@username}"
		string += "\nEmail : #{@email}"
		string += "\nPassword: #{@password}"
	end
end

marcelo = Student.new('Marcelo', 'Dias', 'marcelocd', 'marcelocdias93@gmail.com', '123456')

p marcelo

hashed_password = marcelo.create_hash_digest(marcelo.password)

puts hashed_password