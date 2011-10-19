# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create(:email => '7.scott.j@gmail.com', :login => 'admin', :active => 1, :roles => "1,9", :password => "abc123")
u.save

p = Profile.find_or_initialize_by_user_id(u.id)

p.update_attributes(  :first_name => "Scott", 
                      :middle_name => "S",
                      :last_name => "Johnson",
                      :screen_name => "Scott Johnson",
                      :company => "none",
                      :title => "Developer",
                      :industry => "Travel" )
p.save                      