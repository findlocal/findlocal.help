# Use `rails db:seed assets=false` to skip the cloudinary uploads

def skip_assets? # the question mark can't be used for variables name, but we can use a method
  ENV["assets"] == "false"
end

require "open-uri"

# This prevents URI.open from creating StringIO's for small files, which does't work with Active Storage
OpenURI::Buffer.send(:remove_const, "StringMax") if OpenURI::Buffer.const_defined?("StringMax")
OpenURI::Buffer.const_set("StringMax", 0)

# Define locations, tags and categories here (a task will be generated for each title in categories):
locations = ["Ahmedabad, India", "Baghdad, Iraq", "Bangalore, India", "Bangkok, Thailand", "Beijing, China", "Bogotá, Colombia", "Boston, United States", "Buenos Aires, Argentina", "Cairo, Egypt", "Chengdu, China", "Chennai, India", "Chicago, United States", "Chongqing, China", "Dallas, United States", "Delhi, India", "Dhaka, Bangladesh", "Dongguan, China", "Düsseldorf, Germany", "Guangzhou, China", "Hangzhou, China", "Hanoi, Vietnam", "Ho Chi Minh City, Vietnam", "Hong Kong, China", "Houston, United States", "Hyderabad, India", "Istanbul, Turkey", "Jakarta, Indonesia", "Johannesburg, South Africa", "Karachi, Pakistan", "Kinshasa, DR Congo", "Kolkata, India", "Kuala Lumpur, Malaysia", "Lagos, Nigeria", "Lahore, Pakistan", "Lima, Peru", "London, United Kingdom", "Los Angeles, United States", "Luanda, Angola", "Madrid, Spain", "Manila, Philippines", "Mexico City, Mexico", "Moscow, Russia", "Mumbai, India", "Nagoya, Japan", "Nanjing, China", "New York City, United States", "Onitsha, Nigeria", "Osaka, Japan", "Paris, France", "Pune, India", "Quanzhou, China", "Rio de Janeiro, Brazil", "Riyadh, Saudi Arabia", "San Francisco, United States", "Santiago, Chile", "São Paulo, Brazil", "Seoul, South Korea", "Shanghai, China", "Shenyang, China", "Shenzhen, China", "Surat, India", "Taipei, Taiwan", "Tehran, Iran", "Tianjin, China", "Tokyo, Japan", "Toronto, Canada", "Washington, D.C., United States", "Wuhan, China", "Xi'an, China", "Zhengzhou, China"]

tags = %w[help covid-19 chores housework medical other]

categories = [
  {
    tags: %w[chores help home covid-19 other], # pick some tags from the array above, the first one will be used for the picture!
    titles: ["Home Repair and Maintenance", "Household Fixes", "Seeking Help", "Assist Elderly People", "Fix the Building Elevator", "Seeking Babysitter", "Nanny Wanted", "Help Fix My Busted-up Roof", "Fix My Taxi", "Repair my bicycle", "Fix the Bathroom", "Repair the Entrance Door", "Take Care of the Garden"],
    descriptions: ["I need help to fix it, and the members of my family don't have any experience with it. I would prefer someone who has handyman experience. Thank you.", "I've been living the last 2 months at home with this problem. Please apply if you have experience and want to help me out. Professionals preferred. Happy to negotiate the payment.", "Need help ASAP. My family are currently in a very diffult situation, any kind of help would be highly appreciared. We live just 10 minutes outside the city center."]
  },
  {
    tags: %w[housework help covid-19 medical other],
    titles: ["Shopping For My Grandparents", "Grocery Shopping", "Family Grocery Shopping", "My Daughter Needs Medicines", "Masks For My Family", "Transport My Grandmother", "Bring Kids to School", "Bring My Uncle to the Hospital", "Assistance to Go to the Supermarket"],
    descriptions: ["I urgently need this service weekly. I'm happy to pay an extra if necessary. Please contact me privately or apply here.", "All my family is under quarantine and we need someone to take care of this. Please apply here if you are willing to help.", "Bi-weekly for the next month, or until the situation will improve. No one in my family is currently able to do this independently."]
  }
]

# Display a cool spinner with Whirly! Check https://github.com/janlelis/whirly
Whirly.start(spinner: "dots", status: "Destroying all records", stop: Paint["Done! Local Help is ready to run 🎉", "#28b485"]) do
  sleep 2

  # Destroy everything
  Payment.destroy_all
  Review.destroy_all
  User.destroy_all
  Task.destroy_all
  Help.destroy_all
  TaskTag.destroy_all
  Tag.destroy_all

  # Create users
  Whirly.status = "Creating new users"
  # Women
  10.times do |n|
    user = User.create(
      first_name: Faker::Name.female_first_name,
      last_name: Faker::Name.last_name,
      email: "user#{n + 1}@findlocal.help", # generates user1@findlocal.help, user2@findlocal.help, etc.
      password: "password",
      address: locations.sample,
      phone_number: Faker::PhoneNumber.cell_phone
    )
    next if skip_assets?

    file = URI.open("https://randomuser.me/api/portraits/women/#{n + 1}.jpg")
    user.avatar.attach(io: file, filename: "avatar.jpg", content_type: "image/jpeg")
    user.save
  end
  # Men
  10.times do |n|
    user = User.create(
      first_name: Faker::Name.male_first_name,
      last_name: Faker::Name.last_name,
      email: "man#{n + 11}@findlocal.help", # generates user11@findlocal.help, user12@findlocal.help, etc.
      password: "password",
      address: locations.sample,
      phone_number: Faker::PhoneNumber.cell_phone
    )
    next if skip_assets?

    file = URI.open("https://randomuser.me/api/portraits/men/#{n + 1}.jpg")
    user.avatar.attach(io: file, filename: "avatar.jpg", content_type: "image/jpeg")
    user.save
  end

  # Create tags
  Whirly.status = "Creating tags"
  tags.each { |tag| Tag.create(name: tag) }

  # Create tasks with tags and helps
  Whirly.status = "Creating tasks with tags and helps"
  categories.each do |task_category|
    task_category[:titles].each do |title|
      task_creator = User.all.sample

      task = Task.create(
        title: title,
        description: task_category[:descriptions].sample,
        location: task_creator.address,
        creator: task_creator
        # status is "pending" by default, check the schema!
      )

      # Task tags
      task_tags = Tag.where(name: task_category[:tags]).sample(rand(2..3))
      task_tags.each do |tag|
        TaskTag.create(task: task, tag: tag)
      end

      # Task photos
      unless skip_assets?
        rand(1..4).times do |n|
          file = URI.open("https://loremflickr.com/1600/600/#{task_category[:tags].first}")
          task.photos.attach(io: file, filename: "#{task_category[:tags].first}-task#{n + 1}", content_type: "image/jpeg")
        end
      end

      # Task helps
      rand(1..15).times do
        Help.create(
          user: User.where.not(id: task_creator.id).sample,
          task: task,
          message: [nil, Faker::Quote.matz].sample
        )
      end

      # Assign helper 50% of the time
      if rand > 0.5
        task.update!(helper: task.helps.sample.user) # the status updates automatically to "in progress", check the Task model!
      end
    end
  end

  # Mark some tasks as completed and add reviews (each one 50% of the time)
  Whirly.status = "Creating reviews"
  Task.where(status: "in progress").sample(5).each do |task|
    task.update!(status: "completed")

    # Review from the helper
    if rand > 0.5
      helper_review = Review.create(
        user: task.helper,
        task: task
      )

      ReviewField.create(
        name: "Public Review",
        content: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true, random_sentences_to_add: 5),
        review: helper_review
      )

      ReviewField.create(
        name: "Private Suggestions or Feedback",
        content: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true, random_sentences_to_add: 5),
        review: helper_review
      )

      ReviewField.create(
        name: "Communication",
        content: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 2),
        rating: rand(1..5),
        review: helper_review
      )

      ReviewField.create(
        name: "Accuracy of Task Description",
        content: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 2),
        rating: rand(1..5),
        review: helper_review
      )

      ReviewField.create(
        name: "Availability",
        content: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true, random_sentences_to_add: 5),
        rating: rand(1..5),
        review: helper_review
      )
    end

    # Review from the creator
    if rand > 0.5
      creator_review = Review.create(
        user: task.creator,
        task: task
      )

      ReviewField.create(
        name: "Public Review",
        content: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true, random_sentences_to_add: 5),
        rating: nil,
        review: creator_review
      )

      ReviewField.create(
        name: "Private Suggestions or Feedback",
        content: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true, random_sentences_to_add: 5),
        rating: nil,
        review: creator_review
      )

      ReviewField.create(
        name: "Communication",
        content: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 2),
        rating: rand(1..5),
        review: creator_review
      )

      ReviewField.create(
        name: "Quality of Service",
        content: Faker::Lorem.paragraph(sentence_count: 1, supplemental: true, random_sentences_to_add: 2),
        rating: rand(1..5),
        review: creator_review
      )

      ReviewField.create(
        name: "Professionalism",
        content: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 2),
        rating: rand(1..5),
        review: creator_review
      )
    end

    # Clear and print stop message specified before
    Whirly.status = ""
  end
end
