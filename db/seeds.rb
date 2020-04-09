# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Task.destroy_all
TaskApplication.destroy_all
TaskTag.destroy_all
Tag.destroy_all

20.times do
  User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    address: Faker::Address.full_address,
    phone_number: Faker::PhoneNumber.cell_phone
  ).save
  puts 'Creating User'
end

30.times do
  Task.new(
    title: Faker::Job.field,
    description: Faker::GreekPhilosophers.quote,
    due_date: Faker::Date.forward,
    location: Faker::Address.city,
    status: ['completed', 'in progress', 'pending'].sample,
    creator_id: User.all.sample.id,
    helper_id: User.all.sample.id
  ).save
  puts 'Creating Task'
end

50.times do
  TaskApplication.new(
    user_id: User.all.sample.id,
    task_id: Task.all.sample.id
  ).save
  puts 'Creating Task Application'
end

20.times do
  Tag.new(
    name: Faker::GreekPhilosophers.name
  ).save
  puts 'Creating Tag'
end

100.times do
  TaskTag.new(
    task_id: Task.all.sample.id,
    tag_id: Tag.all.sample.id
  ).save
  puts 'Creating TaskTag'
end
