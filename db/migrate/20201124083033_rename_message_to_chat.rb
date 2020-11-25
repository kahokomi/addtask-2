class RenameMessageToChat < ActiveRecord::Migration[5.2]
  def change
    rename_table :messages, :chats
  end
end
