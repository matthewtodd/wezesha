class AddRecipientToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :recipient, :string
  end

  def self.down
    remove_column :messages, :recipient
  end
end
