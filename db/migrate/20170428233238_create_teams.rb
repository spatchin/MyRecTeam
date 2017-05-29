class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.text :description
      t.string :location
      t.integer :wins
      t.integer :losses
      t.integer :draws
      t.belongs_to :user
      t.belongs_to :captain

      t.timestamps
    end
  end
end
