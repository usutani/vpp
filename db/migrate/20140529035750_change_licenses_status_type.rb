class ChangeLicensesStatusType < ActiveRecord::Migration
  def up
    rename_column :licenses, :status, :status_string
    add_column :licenses, :status, :integer
    License.find_each do |license|
      license.status = license.status_string.downcase
      license.save
    end
  end

  def down
    License.find_each do |license|
      license.status_string = license.status.capitalize
      license.save
    end
    remove_column :licenses, :status
    rename_column :licenses, :status_string, :status
  end
end
