class CreateAccountEntries < ActiveRecord::Migration
  def self.up
    create_table :account_entries do |t|
      t.references :account
      t.references :source, :polymorphic => true

      t.integer :cents

      t.timestamps
    end
  end

  def self.down
    drop_table :account_entries
  end
end
