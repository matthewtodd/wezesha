# This file is auto-generated from the current state of the database. Instead of editing this file,
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090225122108) do

  create_table "account_entries", :force => true do |t|
    t.integer  "account_id"
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "cents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounts", :force => true do |t|
    t.integer  "invitation_id"
    t.string   "subdomain"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "administrators", :force => true do |t|
    t.string   "email",               :null => false
    t.string   "crypted_password",    :null => false
    t.string   "password_salt",       :null => false
    t.string   "persistence_token",   :null => false
    t.string   "single_access_token", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "source_id"
    t.string   "source_type"
    t.string   "code"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.string   "recipient"
    t.text     "text"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_notifications", :force => true do |t|
    t.integer  "payment_id"
    t.text     "notification"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "cents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscribers", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "account_id"
    t.string   "email",               :null => false
    t.string   "crypted_password",    :null => false
    t.string   "password_salt",       :null => false
    t.string   "persistence_token",   :null => false
    t.string   "single_access_token", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
