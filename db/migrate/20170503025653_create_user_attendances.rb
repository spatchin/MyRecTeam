class CreateUserAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :user_attendances do |t|
      t.belongs_to :game
      t.belongs_to :team
      t.belongs_to :user
      t.integer :status

      t.timestamps
    end
  end
end
