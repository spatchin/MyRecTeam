class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :name
      t.datetime :time
      t.string :location
      t.text :notes
      t.integer :status
      t.belongs_to :user

      t.timestamps
    end
  end
end
