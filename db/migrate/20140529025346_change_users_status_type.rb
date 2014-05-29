class ChangeUsersStatusType < ActiveRecord::Migration
  def up
    rename_column :users, :status, :status_string
    add_column :users, :status, :integer
    User.find_each do |user|
      user.status = user.status_string.downcase
      user.save
    end
  end

  def down
    User.find_each do |user|
      user.status_string = user.status.capitalize
      user.save
    end
    remove_column :users, :status
    rename_column :users, :status_string, :status
  end
end
