class AddUniquenessIndex < ActiveRecord::Migration
  def change
    add_index :users, :client_user_id_str, unique: true
    add_index :users, :user_id, unique: true
    add_index :licenses, :license_id, unique: true
    add_index :licenses, :user_id
    add_index :licenses, :adam_id
    add_index :contents, :adam_id, unique: true
  end
end
