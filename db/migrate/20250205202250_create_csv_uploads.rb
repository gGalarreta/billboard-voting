class CreateCsvUploads < ActiveRecord::Migration[8.0]
  def change
    create_table :csv_uploads do |t|
      t.integer :status
      t.string :error_reason
      t.timestamps
    end
  end
end
