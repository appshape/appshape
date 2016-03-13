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

ActiveRecord::Schema.define(version: 20151227153808) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"
  enable_extension "uuid-ossp"

  create_table "conditions", force: :cascade do |t|
    t.string   "code",                          null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "value_required", default: true, null: false
  end

  create_table "conditions_sources", id: false, force: :cascade do |t|
    t.integer "condition_id"
    t.integer "source_id"
  end

  add_index "conditions_sources", ["condition_id"], name: "index_conditions_sources_on_condition_id", using: :btree
  add_index "conditions_sources", ["source_id"], name: "index_conditions_sources_on_source_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "http_headers", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "http_headers", ["name"], name: "index_http_headers_on_name", unique: true, using: :btree

  create_table "http_methods", force: :cascade do |t|
    t.string   "code",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "http_methods", ["code"], name: "index_http_methods_on_code", unique: true, using: :btree

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "identities", ["provider", "uid"], name: "index_identities_on_provider_and_uid", unique: true, using: :btree

  create_table "intervals", force: :cascade do |t|
    t.string   "code",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "value"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "code",                      null: false
    t.boolean  "active",     default: true, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "organization_users", id: false, force: :cascade do |t|
    t.integer "organization_id", null: false
    t.integer "user_id",         null: false
    t.integer "role"
  end

  add_index "organization_users", ["organization_id"], name: "index_organization_users_on_organization_id", using: :btree
  add_index "organization_users", ["user_id", "organization_id"], name: "index_organization_users_on_user_id_and_organization_id", using: :btree
  add_index "organization_users", ["user_id"], name: "index_organization_users_on_user_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.string   "type",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "creator_id",              null: false
    t.string   "slug"
  end

  add_index "organizations", ["creator_id"], name: "index_organizations_on_creator_id", using: :btree
  add_index "organizations", ["slug"], name: "index_organizations_on_slug", unique: true, using: :btree

  create_table "project_users", id: false, force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "user_id",    null: false
  end

  add_index "project_users", ["project_id"], name: "index_project_users_on_project_id", using: :btree
  add_index "project_users", ["user_id", "project_id"], name: "index_project_users_on_user_id_and_project_id", using: :btree
  add_index "project_users", ["user_id"], name: "index_project_users_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "organization_id"
    t.string   "slug"
  end

  add_index "projects", ["slug", "organization_id"], name: "index_projects_on_slug_and_organization_id", unique: true, using: :btree

  create_table "requests", force: :cascade do |t|
    t.integer  "test_id"
    t.string   "url",                 null: false
    t.string   "http_method",         null: false
    t.text     "description"
    t.string   "basic_auth_user"
    t.string   "basic_auth_password"
    t.json     "headers"
    t.json     "url_params"
    t.json     "form_params"
    t.text     "body"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.json     "assertions"
    t.json     "data_points"
  end

  create_table "sources", force: :cascade do |t|
    t.string   "code",                              null: false
    t.boolean  "property_required", default: false, null: false
    t.integer  "position"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "test_runs", force: :cascade do |t|
    t.integer  "test_id",                                null: false
    t.string   "location",                               null: false
    t.boolean  "result",                  default: true
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.json     "failed_assertions"
    t.string   "response_body_file_path"
    t.datetime "executed_at"
    t.string   "grouping_code",                          null: false
  end

  create_table "tests", force: :cascade do |t|
    t.string   "name",                           null: false
    t.text     "description"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "locations",                                   array: true
    t.string   "interval",                       null: false
    t.boolean  "active",          default: true, null: false
    t.datetime "last_run_at"
    t.string   "last_run_result"
    t.integer  "last_run_id"
    t.integer  "project_id"
  end

  add_index "tests", ["project_id"], name: "index_tests_on_project_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "projects", "organizations"
  add_foreign_key "tests", "projects"
end
