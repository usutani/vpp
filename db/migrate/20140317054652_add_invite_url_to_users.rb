class AddInviteUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invite_url, :string
    add_column :users, :invite_code, :string
  end
end
