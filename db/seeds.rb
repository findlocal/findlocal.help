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
BASE_URL = "https://randomuser.me/api/portraits/men/"
30.times do |n|
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

name: technology
name: shopping
name: repairs
name: 

puts "Creating tags..."
20.times do
  Tag.create(
    name: "computing",
    name: "repairs",
    name: "cleaning",
    name: "other shopping",
    name: "advice",
    name: "mobile phone",
    name: "food collection",
    name: "groceries",
    name: "moving home",
    name: "assembling furniture",
    name: "outdoor maintenance",
    name: "garden",
    name: "other",
  )
end

puts "Creating tasks with helps..."
100.times do
  task = Task.create(
    title: Faker::Job.field,
    description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 16),
    due_date: Faker::Date.forward,
    location: Faker::Address.city,
    status: ["completed", "in progress", "pending"].sample,
    creator: User.all.sample,
    helper: [User.all.sample, nil].sample # could be not assigned yet, so let's do 50% of the times
  )

  rand(1..3).times do |n|
  puts "Creating Task Photo..."

    file = URI.open("https://picsum.photos/500")
    task.photos.attach(io: file, filename: "photo#{n + 1}", content_type: 'image/jpeg')
  end

  rand(1..10).times do
    TaskTag.create(
      task_id: task.id,
      tag: Tag.all.sample
    )

    Help.create(
      user: User.all.sample,
      task_id: task.id
    )
  end
end

puts "Done! 🎉"
