class AddTockenToUserAttendances < ActiveRecord::Migration[5.0]
  def change
    add_column :user_attendances, :token, :string
  end
end
