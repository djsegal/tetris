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

ActiveRecord::Schema.define(version: 20150901022447) do

  create_table "blocks", force: :cascade do |t|
    t.integer  "permutation_id"
    t.integer  "x_pos"
    t.integer  "y_pos"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "blocks", ["permutation_id"], name: "index_blocks_on_permutation_id"

  create_table "current_pieces", force: :cascade do |t|
    t.integer  "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "current_pieces", ["player_id"], name: "index_current_pieces_on_player_id"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "games", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "number_of_players"
    t.string   "mode"
    t.string   "name"
    t.string   "slug"
  end

  add_index "games", ["slug"], name: "index_games_on_slug", unique: true

  create_table "grids", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "height",      default: 20
    t.integer  "width",       default: 10
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "top_buffer",  default: 2
    t.integer  "bot_buffer",  default: 3
    t.integer  "side_buffer", default: 2
  end

  add_index "grids", ["player_id"], name: "index_grids_on_player_id"

  create_table "hold_pieces", force: :cascade do |t|
    t.integer  "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "hold_pieces", ["player_id"], name: "index_hold_pieces_on_player_id"

  create_table "permutations", force: :cascade do |t|
    t.integer  "piece_id"
    t.integer  "ordering_index"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "permutations", ["piece_id"], name: "index_permutations_on_piece_id"

  create_table "piece_previews", force: :cascade do |t|
    t.integer  "visible_count", default: 3
    t.integer  "player_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "piece_previews", ["player_id"], name: "index_piece_previews_on_player_id"

  create_table "pieces", force: :cascade do |t|
    t.integer  "grid_id"
    t.integer  "x_pos"
    t.integer  "y_pos"
    t.string   "piece_type"
    t.string   "color"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "piece_preview_id"
    t.integer  "current_piece_id"
    t.integer  "ordering_index"
    t.integer  "width",            default: 3
    t.integer  "hold_piece_id"
  end

  add_index "pieces", ["current_piece_id"], name: "index_pieces_on_current_piece_id"
  add_index "pieces", ["grid_id"], name: "index_pieces_on_grid_id"
  add_index "pieces", ["hold_piece_id"], name: "index_pieces_on_hold_piece_id"
  add_index "pieces", ["piece_preview_id"], name: "index_pieces_on_piece_preview_id"

  create_table "players", force: :cascade do |t|
    t.integer  "score"
    t.integer  "game_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "ordering_index"
  end

  add_index "players", ["game_id"], name: "index_players_on_game_id"

end
