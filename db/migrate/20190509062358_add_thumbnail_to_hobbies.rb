class AddThumbnailToHobbies < ActiveRecord::Migration[5.1]
  def change
    add_column :hobbies, :thumbnail, :string
  end
end
