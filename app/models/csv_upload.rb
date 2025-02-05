class CsvUpload < ApplicationRecord
  has_one_attached :file

  enum :status, { failed: 0, processing: 1, success: 2 }, enums: true, default: :processing
end
