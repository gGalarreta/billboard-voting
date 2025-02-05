class CreateBillboardInteractions < ActiveRecord::Migration[8.0]
  def change
    create_table :billboard_interactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :billboard, null: false, foreign_key: true
      t.integer :reaction, null: false
      t.timestamps
    end
  end
end
