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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150425185330) do

  create_table "playlists", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",       null: false
    t.string   "token",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "playlists", ["name"], name: "index_playlists_on_name", unique: true

  create_table "playlists_tracks", id: false, force: :cascade do |t|
    t.integer "playlist_id"
    t.integer "track_id"
  end

  add_index "playlists_tracks", ["playlist_id"], name: "index_playlists_tracks_on_playlist_id"
  add_index "playlists_tracks", ["track_id"], name: "index_playlists_tracks_on_track_id"

  create_table "streams", force: :cascade do |t|
    t.string   "path"
    t.integer  "size"
    t.string   "content_type"
    t.integer  "duration"
    t.string   "hexdigest"
    t.integer  "track_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "tracks", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "album"
    t.string   "artist"
    t.string   "title"
    t.string   "track_number"
    t.string   "hexdigest"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "tracks", ["album"], name: "index_tracks_on_album"
  add_index "tracks", ["artist"], name: "index_tracks_on_artist"
  add_index "tracks", ["hexdigest"], name: "index_tracks_on_hexdigest"
  add_index "tracks", ["title"], name: "index_tracks_on_title"

  create_table "tracks_playlists", id: false, force: :cascade do |t|
    t.integer "playlist_id"
    t.integer "track_id"
  end

  add_index "tracks_playlists", ["playlist_id"], name: "index_tracks_playlists_on_playlist_id"
  add_index "tracks_playlists", ["track_id"], name: "index_tracks_playlists_on_track_id"

  create_table "users", force: :cascade do |t|
    t.string   "username",               default: "", null: false
    t.string   "avatar"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
