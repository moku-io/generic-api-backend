class AddIndexToAuthToken < ActiveRecord::Migration
  def change
    add_index :users, :authentication_token
  end
end
