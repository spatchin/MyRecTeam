class AddTockenToUserAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :user_attendances, :token, :string
  end
end
