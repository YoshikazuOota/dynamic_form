class CreateValues < ActiveRecord::Migration[5.0]
  def change
    create_table :values do |t|
      t.integer :submit_id
      t.integer :item_id
      t.text :str
      t.datetime :datetime
      t.integer :int

      t.timestamps
    end
  end
end
