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

ActiveRecord::Schema.define(version: 20150829030616) do

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

  create_table "games", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "number_of_players"
  end

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
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "piece_preview_id"
    t.integer  "current_piece_id"
  end

  add_index "pieces", ["current_piece_id"], name: "index_pieces_on_current_piece_id"
  add_index "pieces", ["grid_id"], name: "index_pieces_on_grid_id"
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
