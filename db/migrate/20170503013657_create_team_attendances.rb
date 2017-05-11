class CreateTeamAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :team_attendances do |t|
      t.belongs_to :game, foreign_key: true
      t.belongs_to :team, foreign_key: true
      t.integer :status
      t.integer :score

      t.timestamps
    end
  end
end
