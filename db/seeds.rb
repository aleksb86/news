puts 'Create default roles:'
admin = Role.create! name: 'Admin', description: 'Admin role, who can CRUD any application object'
writer = Role.create! name: 'Writer', description: 'Writer role - can create new post and edit posts which he created'
guest = Role.create! name: 'Guest', description: 'Unregistered user - can view and search public data'
puts 'Roles created: ' << admin.name, writer.name, guest.name
puts 'Create default admin and moder:'
admin.users.create! name: 'Admin', email: 'alex.is.awesome@gmail.com', password: 'qwerty', password_confirmation: 'qwerty'
writer.users.create! name: 'Moder', email: 'moder24@gmail.com', password: 'qwerty', password_confirmation: 'qwerty'
puts 'Users created: ' << User.find_by(name: "Admin").name, User.find_by(name: "Moder").name
