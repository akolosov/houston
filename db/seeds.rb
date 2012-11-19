# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Role.create([ { :name => 'admin' }, { :name => 'manager' } ], :without_protection => true)

admin = User.create :username => 'admin', :email => 'admin@test.com', :password => 'admin', :password_confirmation => 'admin'
admin.save
admin.add_role :admin

user = User.create :username => 'manager', :email => 'manager@test.com', :password => 'manager', :password_confirmation => 'manager'
user.save
user.add_role :manager
