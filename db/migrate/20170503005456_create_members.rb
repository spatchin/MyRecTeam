class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.belongs_to :user
      t.belongs_to :team
      t.integer :role
      t.datetime :accepted_at
      t.string :token

      t.timestamps
    end
  end
end
