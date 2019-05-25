class CreateClips < ActiveRecord::Migration[5.1]
  def change
    create_table :clips do |t|
      t.references :user, foreign_key: true
      t.references :hobby, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :hobby_id], unique: true
    end
  end
end
