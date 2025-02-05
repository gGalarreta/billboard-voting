FactoryBot.define do
  factory :csv_upload do
    status { 1 }
    after(:build) do |csv_upload|
      csv_upload.file.attach(
        io: File.open(Rails.root.join('spec/fixtures/csv_test.csv')),
        filename: 'csv_test.csv',
        content_type: 'text/csv'
      )
    end
  end
end
