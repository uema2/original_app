class RenameTypeColumnToHobbies < ActiveRecord::Migration[5.1]
  def change
    rename_column :hobbies, :type, :kind
  end
end
