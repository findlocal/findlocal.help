# Use `rails db:seed assets=false` to skip the cloudinary uploads

def skip_assets? # the question mark can't be used for variables name, but we can use a method
  ENV["assets"] == "false"
end

require "open-uri"

# This prevents URI.open from creating StringIO's for small files, which does't work with Active Storage
OpenURI::Buffer.send(:remove_const, "StringMax") if OpenURI::Buffer.const_defined?("StringMax")
OpenURI::Buffer.const_set("StringMax", 0)

# Define locations, tags and categories here (a task will be generated for each title in categories):
locations = ["Lombardy, Italy", 	"Turin, Italy", 	"Genoa, Italy", 	"Bologna, Italy", 	"Venice, Italy", 	"Verona, Italy", 	"Padua, Italy", 	"Trieste, Italy", 	"Brescia, Italy", 	"Parma, Italy", 	"Modena, Italy", 	"Reggio Emilia, Italy", 	"Ravenna, Italy", 	"Rimini, Italy", 	"Ferrara, Italy", 	"Monza, Italy", 	"Bergamo, Italy", 	"Trento, Italy", 	"Forlì, Italy", 	"Vicenza, Italy", 	"Bolzano, Italy", 	"Novara, Italy", 	"Piacenza, Italy", 	"Abbiategrasso, Italy", 	"Albairate, Italy", 	"Arconate, Italy", 	"Arese, Italy", 	"Arluno, Italy", 	"Assago, Italy", 	"Baranzate, Italy", 	"Bareggio, Italy", 	"Basiano, Italy", 	"Basiglio, Italy", 	"Bellinzago Lombardo, Italy", 	"Bernate Ticino, Italy", 	"Besate, Italy", 	"Binasco, Italy", 	"Boffalora sopra Ticino, Italy", 	"Bollate, Italy", 	"Bresso, Italy", 	"Bubbiano, Italy", 	"Buccinasco, Italy", 	"Buscate, Italy", 	"Bussero, Italy", 	"Busto Garolfo, Italy", 	"Calvignasco, Italy", 	"Cambiago, Italy", 	"Canegrate, Italy", 	"Carpiano, Italy", 	"Carugate, Italy", 	"Casarile, Italy", 	"Casorezzo, Italy", 	"Cassano d'Adda, Italy", 	"Cassina de' Pecchi, Italy", 	"Cassinetta di Lugagnano, Italy", 	"Castano Primo, Italy", 	"Cernusco sul Naviglio, Italy", 	"Cerro al Lambro, Italy", 	"Cerro Maggiore, Italy", 	"Cesano Boscone, Italy", 	"Cesate, Italy", 	"Cinisello Balsamo, Italy", 	"Cisliano, Italy", 	"Cologno Monzese, Italy", 	"Colturano, Italy", 	"Corbetta, Italy", 	"Cormano, Italy", 	"Cornaredo, Italy", 	"Corsico, Italy", 	"Cuggiono, Italy", 	"Cusago, Italy", 	"Cusano Milanino, Italy", 	"Dairago, Italy", 	"Dresano, Italy", 	"Gaggiano, Italy", 	"Garbagnate Milanese, Italy", 	"Gessate, Italy", 	"Gorgonzola, Italy", 	"Grezzago, Italy", 	"Gudo Visconti, Italy", 	"Inveruno, Italy", 	"Inzago, Italy", 	"Lacchiarella, Italy", 	"Lainate, Italy", 	"Legnano, Italy", 	"Liscate, Italy", 	"Locate di Triulzi, Italy", 	"Magenta, Italy", 	"Magnago, Italy", 	"Marcallo con Casone, Italy", 	"Masate, Italy", 	"Mediglia, Italy", 	"Melegnano, Italy", 	"Melzo, Italy", 	"Mesero, Italy", 	"Milano [Milan], Italy", 	"Morimondo, Italy", 	"Motta Visconti, Italy", 	"Nerviano, Italy", 	"Nosate, Italy", 	"Novate Milanese, Italy", 	"Noviglio, Italy", 	"Opera, Italy", 	"Ossona, Italy", 	"Ozzero, Italy", 	"Paderno Dugnano, Italy", 	"Pantigliate, Italy", 	"Parabiago, Italy", 	"Paullo, Italy", 	"Pero, Italy", 	"Peschiera Borromeo, Italy", 	"Pessano con Bornago, Italy", 	"Pieve Emanuele, Italy", 	"Pioltello, Italy", 	"Pogliano Milanese, Italy", 	"Pozzo d'Adda, Italy", 	"Pozzuolo Martesana, Italy", 	"Pregnana Milanese, Italy", 	"Rescaldina, Italy", 	"Rho, Italy", 	"Robecchetto con Induno, Italy", 	"Robecco sul Naviglio, Italy", 	"Rodano, Italy", 	"Rosate, Italy", 	"Rozzano, Italy", 	"San Colombano al Lambro, Italy", 	"San Donato Milanese, Italy", 	"San Giorgio su Legnano, Italy", 	"San Giuliano Milanese, Italy", 	"Santo Stefano Ticino, Italy", 	"San Vittore Olona, Italy", 	"San Zenone al Lambro, Italy", 	"Sedriano, Italy", 	"Segrate, Italy", 	"Senago, Italy", 	"Sesto San Giovanni, Italy", 	"Settala, Italy", 	"Settimo Milanese, Italy", 	"Solaro, Italy", 	"Trezzano Rosa, Italy", 	"Trezzano sul Naviglio, Italy", 	"Trezzo sull'Adda, Italy", 	"Tribiano, Italy", 	"Truccazzano, Italy", 	"Turbigo, Italy", 	"Vanzaghello, Italy", 	"Vanzago, Italy", 	"Vaprio d'Adda, Italy", 	"Vermezzo, Italy", 	"Vernate, Italy", 	"Vignate, Italy", 	"Villa Cortese, Italy", 	"Vimodrone, Italy", 	"Vittuone, Italy", 	"Vizzolo Predabissi, Italy", 	"Zelo Surrigone, Italy", 	"Zibido San Giacomo, Italy"]

tags = %w[chores cleaning gardening repairs technology shopping medical moving advice covid-19]

latitudes = [45.4642, 45.442, 45.4374, 45.4426, 45.4634, 44.998, 45.4669, 45.4532, 45.4402, 43.4676, 45.4587, 45.477, 45.89, 47.34, 47.94, 45.65, 46.334]
longitudes = [9.1834, 9.1865, 9.1856, 9.19183, 9.19765, 9.18023, 9.18034, 9.19245, 9.2013, 9.1845, 9.1745, 9.1877, 9.1988, 9.33, 9.202, 9.43, 9.1504]

categories = [
  {
    tags: %w[chores cleaning gardening repairs technology shopping medical moving advice covid-19], # pick some tags from the array above, the first one will be used for the picture!
    titles: ["Home Repair and Maintenance", "Household Fixes", "Seeking Help", "Assist Elderly People", "Fix the Building Elevator", "Seeking Babysitter", "Nanny Wanted", "Help Fix My Busted-up Roof", "Fix My Taxi", "Repair my bicycle", "Fix the Bathroom", "Repair the Entrance Door", "Take Care of the Garden"],
    descriptions: ["I need help to fix it, and the members of my family don't have any experience with it. I would prefer someone who has handyman experience. Thank you.", "I've been living the last 2 months at home with this problem. Please apply if you have experience and want to help me out. Professionals preferred. Happy to negotiate the payment.", "Need help ASAP. My family are currently in a very difficult situation, any kind of help would be highly appreciated. We live just 10 minutes outside the city center."]
  },
  {
    tags: %w[chores cleaning gardening repairs technology shopping medical moving advice covid-19],
    titles: ["Shopping For My Grandparents", "Grocery Shopping", "Family Grocery Shopping", "My Daughter Needs Medicine", "Masks For My Family", "Transport My Grandmother", "Bring Kids to School", "Bring My Uncle to the Hospital", "Assistance to Go to the Supermarket"],
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
          message: [nil, Faker::Quote.matz].sample,
          bid: rand(10..200)
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
