class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :model, default: "", null: false
      t.integer :category_id, default: 0, null: false
      t.integer :brand_id, default: 0, null: false

      t.timestamps
    end
  end
end
