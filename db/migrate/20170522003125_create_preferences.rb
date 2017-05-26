class CreatePreferences < ActiveRecord::Migration[5.0]
  def change
    create_table :preferences do |t|
      t.belongs_to :user
      t.time :game_email_reminder, default: '9AM'.to_time.utc

      t.timestamps
    end
  end
end
