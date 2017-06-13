class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :name
      t.datetime :time
      t.string :location
      t.text :notes
      t.integer :status
      t.belongs_to :user, foreign_key: true
      t.belongs_to :team, foreign_key: true

      t.timestamps
    end
  end
end