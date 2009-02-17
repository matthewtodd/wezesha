class CreateMobiles < ActiveRecord::Migration
  def self.up
    create_table :mobiles do |t|
      t.references :user

      t.string :number
      t.string :token
      t.timestamp :verified_at

      t.timestamps
    end
  end

  def self.down
    drop_table :mobiles
  end
end
