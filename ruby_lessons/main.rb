require_relative 'crud'

users = [
	{username: 'danny',   password: 'marcelolindo'},
	{username: 'ben',     password: 'reidacreche'},
	{username: 'laika',   password: 'treinadaparamatar'},
	{username: 'marcelo', password: 'sexmachine'}
]

hashed_users = Crud.create_secure_users(users)

puts hashed_users