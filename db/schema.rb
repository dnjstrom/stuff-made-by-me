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

ActiveRecord::Schema.define(version: 20140116080526) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.tsvector "tsv"
  end

  add_index "posts", ["tsv"], name: "index_posts_on_tsv", using: :gin

  create_trigger("update_tsv_posts", :compatibility => 1).
      name("update_tsv_posts").
      on("posts").
      before(:insert, :update) do
    <<-SQL_ACTIONS
new.tsv :=
     			setweight(to_tsvector('pg_catalog.english', coalesce(new.title,'')), 'A') ||
     			setweight(to_tsvector('pg_catalog.english', coalesce(new.body,'')), 'D');
    SQL_ACTIONS
  end

end
