class ChangeStatusToIntegerInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :status, :integer, using: 'status::integer'
  end
end
