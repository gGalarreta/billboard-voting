DEFAULT_PASSWORD = '123456'
ADMIN_EMAIL = 'admin@adquick.com'
AMOUNT_OF_USERS = 2
AMOUNT_OF_BILLBOARDS = 2
AMOUNT_OF_CSV = 1

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

def create_csv
  csv_upload = CsvUpload.create(status: 1)
  csv_upload.file.attach(
    io: File.open(Rails.root.join('spec/fixtures/csv_test.csv')),
    filename: 'csv_test.csv',
    content_type: 'text/csv'
  )
end


create_csv