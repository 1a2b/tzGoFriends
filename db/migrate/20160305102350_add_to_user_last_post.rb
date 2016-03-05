class AddToUserLastPost < ActiveRecord::Migration
  def change
    add_column :users, :last_post_at, :string
    add_column :users, :posted_message_id, :integer
  end
end
