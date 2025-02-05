require 'csv'

class ImportBillboards
  def initialize(csv_upload_id)
    @csv_upload_id = csv_upload_id
    @data = []
    @malformed_data = []
  end

  def call
    validate_upload_object
    csv_upload.processing!
    map_objects
    validate_data_composition
    import_objects
  end

  private

  attr_reader :csv_upload_id

  def validate_upload_object
    logger.info('Validating csv upload object')
    return if csv_upload.present?

    raise ActiveRecord::RecordNotFound, 'Something went wrong '\
      "at upload the csv file #{csv_upload_id}" 
  end

  def map_objects
    logger.info("Mapping csv file #{csv_upload_id}")
    CSV.foreach(csv_file_path, headers: true) do |row|
      @data << {
        'address' => row['address'],
        'url' => row['url'],
      }
    end
  end

  def validate_data_composition
    logger.info("Validating csv mapped #{csv_upload_id}")
    @malformed_data = @data.select { |hash| hash.values.any?(&:blank?) }
    return if @malformed_data.empty?

    formatted_error = @malformed_data.map do |hash|
      "Address: #{hash[:address].presence || '(empty)'} | URL: #{hash[:url].presence || '(empty)'}"
    end
    csv_upload.update(
      status: 0,
      error_reason: "There are some inputs with blank attributes: #{formatted_error}"
    )
  end

  def import_objects
    logger.info("Import csv mapped #{csv_upload_id}")
    @data.each do |record|
      Billboard.create(record)
    end
    csv_upload.success!
  end

  def csv_upload
    @csv_upload ||= CsvUpload.find_by(id: csv_upload_id)
  end

  def csv_file_path
    @csv_file_path ||= ActiveStorage::Blob.service.send(:path_for, csv_upload.file.key)
  end

  def logger
    @logger ||= Rails.logger
  end
end