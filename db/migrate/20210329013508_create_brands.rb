class CreateBrands < ActiveRecord::Migration[6.1]
  def change
    create_table :brands do |t|
      t.string :name, null: false, default: ""
      t.integer :public_level, default: 1, null: false
      t.integer :row_order

      t.timestamps
    end
    add_index :brands, [:name], unique: true
  end
end
