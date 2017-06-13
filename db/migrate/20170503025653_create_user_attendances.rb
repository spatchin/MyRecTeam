class CreateUserAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :user_attendances do |t|
      t.belongs_to :game, foreign_key: true
      t.belongs_to :team, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
