class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :typ
      t.boolean :presence
      t.boolean :only_integer
      t.string :format_with

      t.timestamps
    end
  end
end
