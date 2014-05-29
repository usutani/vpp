class ChangeUsersStatusType < ActiveRecord::Migration
  def up
    rename_column :users, :status, :status_string
    add_column :users, :status, :integer
    User.find_each do |user|
      # Avoid Apple VPP API
      raw_status = User.statuses[user.status_string.downcase.to_sym]
      user.update_columns(status: raw_status)
    end
  end

  def down
    User.find_each do |user|
      user.update_columns(status_string: user.status.capitalize)
    end
    remove_column :users, :status
    rename_column :users, :status_string, :status
  end
end
