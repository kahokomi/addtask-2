class RenameColumnToChat < ActiveRecord::Migration[5.2]
  def change
    rename_column :chats, :message, :chats
  end
end
