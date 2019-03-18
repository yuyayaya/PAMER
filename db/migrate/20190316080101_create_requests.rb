class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.integer :guide_id
      t.integer :tourist_id
      t.boolean :approved, default: false, null: false

      t.timestamps
    end
      add_index :requests, :guide_id
      add_index :requests, :tourist_id
  end
end
