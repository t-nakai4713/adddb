# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do |n|
  email = Faker::Internet.email
  password = "password"
  name = Faker::Pokemon.name
  add1 = "192.168.0."
  add2 = n+1
  add3 = "/32"
  using_status = Faker::Number.between(0,1)
  ipadd = add1 + add2.to_s + add3

  if using_status ==0
	use = "free"	
  else
	use = Faker::Pokemon.location
	user_id = Faker::Number.between(1,10)
  end

  User.create!(email: email,
               password: password,
               password_confirmation: password,
	       name: name
               )
  Address.create!(ipadd: ipadd,
		  use: use,
		  user_id: user_id,
		  addinfo_id: 1,
		  status: using_status
		)

end

 Addinfo.create!(text_tpl1: "add.txt",
		 text_tpl2: "delete.txt",
		 address_id: 1
		)
