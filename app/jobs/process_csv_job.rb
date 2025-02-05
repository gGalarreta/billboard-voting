class ProcessCsvJob < ApplicationJob
  queue_as :default

  def perform(csv_upload_id)
    ImportBillboards.new(csv_upload_id).call
  end
end
