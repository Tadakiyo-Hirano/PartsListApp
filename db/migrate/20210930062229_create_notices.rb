class CreateNotices < ActiveRecord::Migration[6.1]
  def change
    create_table :notices do |t|
      t.datetime :posted_at, precision: 6, null: false
      t.text :text
      t.boolean :display, default: true, null: false

      t.timestamps
    end
  end
end