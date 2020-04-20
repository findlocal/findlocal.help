require_relative "config/application"

Rails.application.load_tasks

desc "Look for Ruby style offenses in your code"
task rubocop: :environment do
  puts "---"
  puts "Looking for Ruby style offenses in your code..."
  puts "All good! 👌" if system "rubocop --format simple"
end

desc "Look for JavaScript style offenses in your code"
task eslint: :environment do
  puts "---"
  puts "Looking for JavaScript style offenses in your code..."
  puts "All good! 👌" if system "./node_modules/.bin/eslint app/javascript/packs/**/*.js"
end

task default: [:rubocop, :eslint]
