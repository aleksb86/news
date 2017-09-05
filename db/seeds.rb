# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'Create default roles:'
admin = Role.create! name: 'Admin', description: 'Admin role, who can CRUD any application object'
user = Role.create! name: 'User', description: 'User role - can view and search data'
guest = Role.create! name: 'Guest', description: 'Unregistered user - can view and search public data'
puts 'Roles created: ' << admin.name, user.name, guest.name
puts 'Create default admin and user:'
alex = User.create! name: 'Alex', email: 'alex.is.awesome@gmail.com', password: 'qwerty', password_confirmation: 'qwerty', role: 'Admin'
# user = User.create! :name => 'First User', :email => 'user@example.com', :password => 'qwerty123', :password_confirmation => 'qwerty123'
# user2 = User.create! :name => 'Second User', :email => 'user2@example.com', :password => 'qwerty321', :password_confirmation => 'qwerty321'
# puts 'New user created: ' << user2.name
