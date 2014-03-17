class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :client_user_id_str
      t.string :email
      t.string :its_id_hash
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end
end
