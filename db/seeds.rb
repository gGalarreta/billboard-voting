# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

DEFAULT_PASSWORD = '123456'
ADMIN_EMAIL = 'admin@adquick.com'
AMOUNT_OF_USERS = 2
AMOUNT_OF_BILLBOARDS = 2

# Create Users
puts 'Creating Users'

def create_user(email = nil, role = 0)
  email ||= Faker::Internet.email
  password = DEFAULT_PASSWORD
  User.create(email: email, password: password, role: role)
end

admin_user = create_user(ADMIN_EMAIL, role = 1)

AMOUNT_OF_USERS.times do |i|
  create_user("client#{i}@adquick.com")
end

AMOUNT_OF_BILLBOARDS.times do
  Billboard.create(
    address: Faker::Address.full_address,
    url: Faker::Internet.url
  )
end