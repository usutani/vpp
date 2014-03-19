class CreateLicenses < ActiveRecord::Migration
  def change
    create_table :licenses do |t|
      t.integer :license_id
      t.integer :user_id
      t.integer :adam_id
      t.integer :product_type_id
      t.string :its_id_hash
      t.string :pricing_param
      t.string :status
      t.string :product_type_name
      t.boolean :is_irrevocable
      t.string :client_user_id_str

      t.timestamps
    end
  end
end
