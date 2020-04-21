require "open-uri"

# This prevents URI.open from creating StringIO's for small files, which does not work with Active Storage
OpenURI::Buffer.send(:remove_const, "StringMax") if OpenURI::Buffer.const_defined?("StringMax")
OpenURI::Buffer.const_set("StringMax", 0)

puts "Destroying all records..."
Review.destroy_all
User.destroy_all
Task.destroy_all
Help.destroy_all
TaskTag.destroy_all
Tag.destroy_all

puts "Creating new users..."
10.times do |n|
  user = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "user#{n + 1}@localhelp.org", # generate emails user1@localhelp.org, user2@localhelp.org, etc.
    password: "password",
    address: Faker::Address.full_address,
    phone_number: Faker::PhoneNumber.cell_phone
  )
  file = URI.open("https://randomuser.me/api/portraits/women/#{n + 1}.jpg")
  user.avatar.attach(io: file, filename: "avatar.jpg", content_type: "image/jpeg")
  user.save
end

puts "Creating tags..."
%w[help corona chores home-help other].each do |tag|
  Tag.create(name: tag)
end

cities = ["Ahmedabad, India", "Baghdad, Iraq", "Bangalore, India", "Bangkok, Thailand", "Beijing, China", "Bogotá, Colombia", "Boston, United States",  "Buenos Aires, Argentina", "Cairo, Egypt", "Chengdu, China", "Chennai, India", "Chicago, United States", "Chongqing, China", "Dallas, United States", "Delhi, India", "Dhaka, Bangladesh", "Dongguan, China", "Düsseldorf, Germany", "Guangzhou, China", "Hangzhou, China", "Hanoi, Vietnam", "Ho Chi Minh City, Vietnam", "Hong Kong, China", "Houston, United States", "Hyderabad, India", "Istanbul, Turkey", "Jakarta, Indonesia", "Johannesburg, South Africa", "Karachi, Pakistan", "Kinshasa, DR Congo", "Kolkata, India", "Kuala Lumpur, Malaysia", "Lagos, Nigeria", "Lahore, Pakistan", "Lima, Peru", "London, United Kingdom", "Los Angeles, United States", "Luanda, Angola", "Madrid, Spain", "Manila, Philippines", "Mexico City, Mexico", "Moscow, Russia", "Mumbai, India", "Nagoya, Japan", "Nanjing, China", "New York City, United States", "Onitsha, Nigeria", "Osaka, Japan", "Paris, France", "Pune, India", "Quanzhou, China", "Rio de Janeiro, Brazil", "Riyadh, Saudi Arabia", "San Francisco, United States", "Santiago, Chile", "São Paulo, Brazil", "Seoul, South Korea", "Shanghai, China", "Shenyang, China", "Shenzhen, China", "Surat, India", "Taipei, Taiwan", "Tehran, Iran", "Tianjin, China", "Tokyo, Japan", "Toronto, Canada", "Washington, D.C., United States", "Wuhan, China", "Xi'an, China", "Zhengzhou, China"]

home_descriptions = ["I need help with many home projects to fix things inside and outside of my house. Would prefer someone who has handyman experience", "My roof is leaking, please contact me if you have experience working on roof repair. Professionals preferred. Happy to negotiate payment", "Need yard work and tree triming help and small fixes to faucets and door handles in home"]
home_titles = ["Home Repair and Maintenance", "Household Fixes", "Seeking Help"]

shopping_descriptions = ["need weekly groceries delivered to my parents. They also need some other items picked up as requested", "Food shopping for family who is under quarantine", "Bi-weekly groceries shopping for the next month"]
shopping_titles = ["Shopping", "Grocery Shopping", "Family Grocery Shopping"]

puts "Creating tasks with helps..."
5.times do
  task = Task.create(
    title: home_titles.sample,
    description: home_descriptions.sample,
    due_date: rand((Time.zone.today + 3.days)..(Time.zone.today + 1.month)),
    location: cities.sample,
    status: "pending",
    creator: User.all.sample
  )

  # Photos
  rand(1..3).times do |n|
    file = URI.open("https://picsum.photos/500")
    task.photos.attach(io: file, filename: "task1.#{n + 1}", content_type: "image/jpeg")
  end

  # Tags
  Tag.all.sample(rand(1..5)).each do |tag|
    TaskTag.create(task: task, tag: tag)
  end

  # Helps
  rand(0..10).times do
    Help.create(
      user: User.all.sample,
      task: task
    )
  end
end

10.times do
  task = Task.new(
    title: shopping_titles.sample,
    description: shopping_descriptions.sample,
    due_date: rand((Time.zone.today + 3.days)..(Time.zone.today + 1.month)),
    location: cities.sample,
    status: ["in progress", "completed"].sample,
    creator: User.all.sample,
    helper: User.all.sample
  )

  rand(1..3).times do |n|
    file = URI.open("https://picsum.photos/500")
    task.photos.attach(io: file, filename: "task2.#{n + 1}", content_type: "image/jpeg")
  end

  Tag.all.sample(rand(1..5)).each do |tag|
    TaskTag.create(task: task, tag: tag)
  end

  Help.create(
    user: task.helper,
    task: task
  )
end

Task.all.each do |task|
  next unless task.status == "completed"

  # REVIEW: from the helper
  helpers_review = Review.create(
    user: task.helper,
    task: task
  )

  ReviewField.create(
    name: "Public Review",
    content: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true, random_sentences_to_add: 5),
    rating: nil,
    review: helpers_review
  )

  ReviewField.create(
    name: "Private Suggestions or Feedback",
    content: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true, random_sentences_to_add: 5),
    rating: nil,
    review: helpers_review
  )

  ReviewField.create(
    name: "Communication",
    content: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 2),
    rating: rand(1..5),
    review: helpers_review
  )

  ReviewField.create(
    name: "Accuracy of Task Description",
    content: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 2),
    rating: rand(1..5),
    review: helpers_review
  )

  ReviewField.create(
    name: "Availability",
    content: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true, random_sentences_to_add: 5),
    rating: rand(1..5),
    review: helpers_review
  )

  # REVIEW: from the task creator
  creators_review = Review.create(
    user: task.creator,
    task: task
  )

  ReviewField.create(
    name: "Public Review",
    content: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true, random_sentences_to_add: 5),
    rating: nil,
    review: creators_review
  )

  ReviewField.create(
    name: "Private Suggestions or Feedback",
    content: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true, random_sentences_to_add: 5),
    rating: nil,
    review: creators_review
  )

  ReviewField.create(
    name: "Communication",
    content: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 2),
    rating: rand(1..5),
    review: creators_review
  )

  ReviewField.create(
    name: "Quality of Service",
    content: Faker::Lorem.paragraph(sentence_count: 1, supplemental: true, random_sentences_to_add: 2),
    rating: rand(1..5),
    review: creators_review
  )

  ReviewField.create(
    name: "Professionalism",
    content: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 2),
    rating: rand(1..5),
    review: creators_review
  )
end

puts "Done! 🎉"
