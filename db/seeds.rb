# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Rails.env.development?
  User.destroy_all

  p u = User.create!(email: 'admin@glbrc.org', username: 'admin', name: 'admin user', role: 'admin', password: 'secret', password_confirmation: 'secret')
  u.confirm
end