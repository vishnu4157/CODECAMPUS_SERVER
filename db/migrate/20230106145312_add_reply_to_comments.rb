class AddReplyToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :reply, :text
  end
end
