class AddTitleToCsvUpload < ActiveRecord::Migration[8.0]
  def change
    add_column :csv_uploads, :title, :string
  end
end
