puts "Destroying all records..."
User.destroy_all
Task.destroy_all
Help.destroy_all
TaskTag.destroy_all
Tag.destroy_all

puts "Creating new users..."
30.times do |n|
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "user#{n + 1}@localhelp.org", # generate emails user1@localhelp.org, user2@localhelp.org, etc.
    password: "password",
    address: Faker::Address.full_address,
    phone_number: Faker::PhoneNumber.cell_phone
  )
end

puts "Creating tags..."
20.times do
  Tag.create(
    name: Faker::GreekPhilosophers.name
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
