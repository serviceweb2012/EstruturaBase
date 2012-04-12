# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120229170234) do

  create_table "four_oh_fours", :force => true do |t|
    t.string   "host",       :limit => 100
    t.string   "path"
    t.string   "referer"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "number"
    t.string   "district"
    t.string   "city"
    t.string   "state"
    t.string   "uf"
    t.string   "url_site"
    t.string   "cep"
    t.string   "phone"
    t.string   "email"
    t.string   "url_map"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.boolean  "adm"
    t.boolean  "situation",  :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus_roles", :id => false, :force => true do |t|
    t.integer "menu_id"
    t.integer "role_id"
  end

  create_table "permissions", :force => true do |t|
    t.integer  "role_id"
    t.string   "model_name"
    t.string   "actions"
    t.boolean  "situation",  :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "value"
    t.boolean  "situation",  :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_sub_menus", :id => false, :force => true do |t|
    t.integer "sub_menu_id"
    t.integer "role_id"
  end

  create_table "sub_menus", :force => true do |t|
    t.integer  "menu_id"
    t.string   "name"
    t.string   "title"
    t.string   "url"
    t.integer  "position"
    t.boolean  "separator"
    t.boolean  "adm"
    t.boolean  "situation",  :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",   :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username",               :limit => 50
    t.boolean  "situation",                             :default => true
    t.integer  "role_id"
    t.string   "name"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
