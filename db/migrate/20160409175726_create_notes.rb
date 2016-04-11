class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :post_id
      t.string :text

      t.timestamps null: false
    end
  end
end
