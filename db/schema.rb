# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20120917150654) do

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "companies", :force => true do |t|
    t.string   "name",                         :null => false
    t.string   "apikey",                       :null => false
    t.boolean  "jquery",     :default => true, :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "companies", ["apikey"], :name => "index_companies_on_apikey"

  create_table "message_servers", :force => true do |t|
    t.string   "address",    :null => false
    t.integer  "port"
    t.integer  "company_id"
    t.string   "password"
    t.string   "location"
    t.string   "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "message_servers", ["company_id"], :name => "index_message_servers_on_company_id"

  create_table "operator_servers", :force => true do |t|
    t.string   "address",    :null => false
    t.integer  "port"
    t.integer  "company_id"
    t.string   "password"
    t.string   "location"
    t.string   "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "operator_servers", ["company_id"], :name => "index_operator_servers_on_company_id"

  create_table "particular_events", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "content",      :null => false
    t.integer  "url_match_id", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "particular_events", ["url_match_id"], :name => "index_particular_events_on_url_match_id"

  create_table "plugin_combinations", :force => true do |t|
    t.integer  "company_id",          :null => false
    t.string   "name",                :null => false
    t.text     "thumbnail_collector"
    t.text     "content_analyzer"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "plugin_combinations", ["company_id"], :name => "index_plugin_combinations_on_company_id"

  create_table "plugin_combinations_plugins", :id => false, :force => true do |t|
    t.integer "plugin_combination_id", :null => false
    t.integer "plugin_id",             :null => false
  end

  add_index "plugin_combinations_plugins", ["plugin_combination_id", "plugin_id"], :name => "habtm_plugins", :unique => true

  create_table "plugins", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "path",        :null => false
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "url_matches", :force => true do |t|
    t.integer  "company_id",                    :null => false
    t.string   "match",                         :null => false
    t.string   "name",                          :null => false
    t.boolean  "untrack",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "url_matches", ["company_id"], :name => "index_url_matches_on_company_id"
  add_index "url_matches", ["name"], :name => "index_url_matches_on_name"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "company_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["company_id"], :name => "index_users_on_company_id"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "visitor_servers", :force => true do |t|
    t.string   "address",    :null => false
    t.integer  "port"
    t.integer  "company_id"
    t.string   "password"
    t.string   "location"
    t.string   "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "visitor_servers", ["company_id"], :name => "index_visitor_servers_on_company_id"

end
