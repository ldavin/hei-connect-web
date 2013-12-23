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

ActiveRecord::Schema.define(:version => 20131223090616) do

  create_table "absences", :force => true do |t|
    t.datetime "date"
    t.integer  "length"
    t.boolean  "excused"
    t.string   "justification"
    t.integer  "update_number"
    t.integer  "section_id"
    t.integer  "user_session_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "absences", ["section_id"], :name => "index_absences_on_section_id"
  add_index "absences", ["user_session_id"], :name => "index_absences_on_user_session_id"

  create_table "active_admin_comments", :force => true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "course_rooms", :force => true do |t|
    t.integer "course_id"
    t.integer "room_id"
  end

  add_index "course_rooms", ["course_id"], :name => "index_course_rooms_on_course_id"
  add_index "course_rooms", ["room_id"], :name => "index_course_rooms_on_room_id"

  create_table "course_teachers", :force => true do |t|
    t.integer "course_id"
    t.integer "teacher_id"
  end

  add_index "course_teachers", ["course_id"], :name => "index_course_teachers_on_course_id"
  add_index "course_teachers", ["teacher_id"], :name => "index_course_teachers_on_teacher_id"

  create_table "course_users", :force => true do |t|
    t.integer  "update_number"
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "course_users", ["course_id"], :name => "index_course_users_on_course_id"
  add_index "course_users", ["user_id"], :name => "index_course_users_on_user_id"

  create_table "courses", :force => true do |t|
    t.datetime "date"
    t.integer  "length"
    t.string   "kind"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "ecampus_id"
    t.integer  "section_id"
    t.integer  "group_id"
    t.string   "broken_name"
  end

  add_index "courses", ["ecampus_id"], :name => "index_courses_on_ecampus_id"
  add_index "courses", ["group_id"], :name => "index_courses_on_group_id"
  add_index "courses", ["section_id"], :name => "index_courses_on_section_id"

  create_table "exams", :force => true do |t|
    t.string   "name"
    t.date     "date"
    t.string   "kind"
    t.float    "weight"
    t.float    "average"
    t.integer  "grades_count"
    t.integer  "section_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "exams", ["section_id"], :name => "index_exams_on_section_id"

  create_table "grades", :force => true do |t|
    t.float    "mark"
    t.boolean  "unknown"
    t.integer  "update_number"
    t.integer  "user_session_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "exam_id"
  end

  add_index "grades", ["exam_id"], :name => "index_grades_on_exam_id"
  add_index "grades", ["user_session_id"], :name => "index_grades_on_user_session_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "groups", ["name"], :name => "index_groups_on_name"

  create_table "notes", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "rooms", ["name"], :name => "index_rooms_on_name"

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sections", ["name"], :name => "index_sections_on_name"

  create_table "teachers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "teachers", ["name"], :name => "index_teachers_on_name"

  create_table "updates", :force => true do |t|
    t.string   "object"
    t.string   "state"
    t.integer  "rev",        :default => 0
    t.integer  "user_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "updates", ["user_id", "object"], :name => "index_updates_on_user_id_and_object"
  add_index "updates", ["user_id"], :name => "index_updates_on_user_id"

  create_table "user_sessions", :force => true do |t|
    t.integer  "year"
    t.integer  "try",              :default => 1
    t.integer  "absences_session"
    t.integer  "grades_session"
    t.integer  "user_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "update_number"
  end

  add_index "user_sessions", ["user_id"], :name => "index_user_sessions_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "ecampus_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "ics_key"
    t.string   "password_digest"
    t.string   "token"
    t.datetime "last_activity"
  end

  add_index "users", ["ecampus_id"], :name => "index_users_on_ecampus_id"
  add_index "users", ["ics_key"], :name => "index_users_on_ics_key"

end
