class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.integer :adam_id
      t.string :name

      t.timestamps
    end
  end
end
