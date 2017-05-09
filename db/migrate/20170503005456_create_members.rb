class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.belongs_to :user
      t.belongs_to :team
      t.boolean :captain, default: false
      t.integer :role

      t.timestamps
    end
  end
end
