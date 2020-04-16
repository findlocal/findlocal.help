require 'open-uri'

# this prevents URI.open from creating STRINGIO's for small files, which does not work with activestorage
OpenURI::Buffer.send :remove_const, 'StringMax' if OpenURI::Buffer.const_defined?('StringMax')
OpenURI::Buffer.const_set 'StringMax', 0

puts "Destroying all records..."
User.destroy_all
Task.destroy_all
Help.destroy_all
TaskTag.destroy_all
Tag.destroy_all

puts "Creating new users..."
BASE_URL = "https://randomuser.me/api/portraits/women/"
10.times do |n|
  user = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "user#{n + 1}@localhelp.org", # generate emails user1@localhelp.org, user2@localhelp.org, etc.
    password: "password",
    address: Faker::Address.full_address,
    phone_number: Faker::PhoneNumber.cell_phone
  )

  file = URI.open("#{BASE_URL}#{n + 1}.jpg")
  puts "Creating User Avatar..."

  user.avatar.attach(io: file, filename: 'avatar.jpg', content_type: 'image/jpeg')
  user.save
end



tags = ["#help", "#corona", "#chores", "#home-help", "#other"]

puts "Creating tags..."
tags.each do |tag|
  Tag.create(
    name: tag
  )
end

cities = ["Ahmedabad, India",	"Baghdad, Iraq",	"Bangalore, India",	"Bangkok, Thailand",	"Beijing, China",	"Bogotá, Colombia",	"Boston, United States",	"Buenos Aires, Argentina",	"Cairo, Egypt",	"Chengdu, China",	"Chennai, India",	"Chicago, United States",	"Chongqing, China",	"Dallas, United States",	"Delhi, India",	"Dhaka, Bangladesh",	"Dongguan, China",	"Düsseldorf, Germany",	"Guangzhou, China",	"Hangzhou, China",	"Hanoi, Vietnam",	"Ho Chi Minh City, Vietnam",	"Hong Kong, China",	"Houston, United States",	"Hyderabad, India",	"Istanbul, Turkey",	"Jakarta, Indonesia",	"Johannesburg, South Africa",	"Karachi, Pakistan",	"Kinshasa, DR Congo",	"Kolkata, India",	"Kuala Lumpur, Malaysia",	"Lagos, Nigeria",	"Lahore, Pakistan",	"Lima, Peru",	"London, United Kingdom",	"Los Angeles, United States",	"Luanda, Angola",	"Madrid, Spain",	"Manila, Philippines",	"Mexico City, Mexico",	"Moscow, Russia",	"Mumbai, India",	"Nagoya, Japan",	"Nanjing, China",	"New York City, United States",	"Onitsha, Nigeria",	"Osaka, Japan",	"Paris, France",	"Pune, India",	"Quanzhou, China",	"Rio de Janeiro, Brazil",	"Riyadh, Saudi Arabia",	"San Francisco, United States",	"Santiago, Chile",	"São Paulo, Brazil",	"Seoul, South Korea",	"Shanghai, China",	"Shenyang, China",	"Shenzhen, China",	"Surat, India",	"Taipei, Taiwan",	"Tehran, Iran",	"Tianjin, China",	"Tokyo, Japan",	"Toronto, Canada",	"Washington, D.C., United States",	"Wuhan, China",	"Xi'an, China",	"Zhengzhou, China"]

taskdescription_homerepair = ["I need help with many home projects to fix things inside and outside of my house. Would prefer someone who has handyman experience", "My roof is leaking, please contact me if you have experience working on roof repair. Professionals preferred. Happy to negotiate payment", "Need yard work and tree triming help and small fixes to faucets and door handles in home"]
tasktitle_homerepair = ["Home Repair and Maintenance", "Household Fixes", "Seeking Help"]

taskdescription_shopping = ["need weekly groceries delivered to my parents. They also need some other items picked up as requested", "Food shopping for family who is under quarantine", "Bi-weekly groceries shopping for the next month"]
tasktitle_shopping = ["Shopping", "Grocery Shopping", "Family Grocery Shopping"] 

taskdescription_transportation = []
tasktitle_transportation = []

puts "Creating tasks with helps for homerepair..."
3.times do
  task = Task.create(
    title: tasktitle_homerepair.sample,
    description: taskdescription_homerepair.sample,
    due_date: rand(Date.today..Date.civil(2020, 05, 01)),
    location: cities.sample,
    status: "pending",
    creator: User.all.sample,
    helper: [User.all.sample, nil].sample # could be not assigned yet, so let's do 50% of the times
  )

  rand(1..3).times do |n|
    puts "Creating Task Photo..."
    file = URI.open("https://picsum.photos/500")
    task.photos.attach(io: file, filename: "photo#{n + 1}", content_type: 'image/jpeg')
  end

  Tag.all.sample(rand(1..5)).each do |tag|
    TaskTag.create(task: task, tag: tag)
  end

  rand(0..10).times do
    Help.create(
      user: User.all.sample,
      task: task
    )
  end
end

puts "Creating tasks with helps for shopping..."
3.times do
  task = Task.create(
    title: tasktitle_shopping.sample,
    description: taskdescription_shopping.sample,
    due_date: rand(Date.today..Date.civil(2020, 05, 01)),
    location: cities.sample,
    status: "pending",   
    creator: User.all.sample,
    helper: [User.all.sample, nil].sample # could be not assigned yet, so let's do 50% of the times
  )
    
  rand(1..3).times do |n|
    puts "Creating Task Photo..."
    file = URI.open("https://picsum.photos/500")
    task.photos.attach(io: file, filename: "photo#{n + 1}", content_type: 'image/jpeg')
  end

  Tag.all.sample(rand(1..5)).each do |tag|
    TaskTag.create(task: task, tag: tag)
  end

  rand(0..10).times do
    Help.create(
      user: User.all.sample,
      task: task
    )
  end
end

puts "Done! 🎉"
