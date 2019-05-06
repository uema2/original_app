class CreateHobbies < ActiveRecord::Migration[5.1]
  def change
    create_table :hobbies do |t|
      t.string :title
      t.text :content
      t.integer :type
      t.integer :category
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
