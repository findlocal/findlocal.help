require_relative "config/application"

Rails.application.load_tasks

task :rubocop do
  puts "---"
  puts "Analyzing your ruby style..."
  puts "All good! 👌" if system "rubocop --format simple"
end

task :eslint do
  puts "---"
  puts "Analyzing your javascript style..."
  puts "All good! 👌" if system "./node_modules/.bin/eslint app/javascript/packs/**/*.js"
end

task default: [:rubocop, :eslint]
