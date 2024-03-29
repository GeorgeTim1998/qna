# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_220_822_120_434) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'achievements', force: :cascade do |t|
    t.string 'name', null: false
    t.bigint 'question_id', null: false
    t.bigint 'winner_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['question_id'], name: 'index_achievements_on_question_id'
    t.index ['winner_id'], name: 'index_achievements_on_winner_id'
  end

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'answers', force: :cascade do |t|
    t.text 'body', null: false
    t.bigint 'question_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'author_id', null: false
    t.boolean 'best', default: false, null: false
    t.index ['author_id'], name: 'index_answers_on_author_id'
    t.index ['question_id'], name: 'index_answers_on_question_id'
  end

  create_table 'comments', force: :cascade do |t|
    t.string 'body'
    t.bigint 'author_id', null: false
    t.string 'commentable_type', null: false
    t.bigint 'commentable_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['author_id'], name: 'index_comments_on_author_id'
    t.index %w[commentable_type commentable_id], name: 'index_comments_on_commentable'
  end

  create_table 'links', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'url', null: false
    t.string 'linkable_type'
    t.bigint 'linkable_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[linkable_type linkable_id], name: 'index_links_on_linkable'
  end

  create_table 'oauth_access_grants', force: :cascade do |t|
    t.bigint 'resource_owner_id', null: false
    t.bigint 'application_id', null: false
    t.string 'token', null: false
    t.integer 'expires_in', null: false
    t.text 'redirect_uri', null: false
    t.datetime 'created_at', null: false
    t.datetime 'revoked_at'
    t.string 'scopes', default: '', null: false
    t.index ['application_id'], name: 'index_oauth_access_grants_on_application_id'
    t.index ['resource_owner_id'], name: 'index_oauth_access_grants_on_resource_owner_id'
    t.index ['token'], name: 'index_oauth_access_grants_on_token', unique: true
  end

  create_table 'oauth_access_tokens', force: :cascade do |t|
    t.bigint 'resource_owner_id'
    t.bigint 'application_id', null: false
    t.string 'token', null: false
    t.string 'refresh_token'
    t.integer 'expires_in'
    t.datetime 'revoked_at'
    t.datetime 'created_at', null: false
    t.string 'scopes'
    t.string 'previous_refresh_token', default: '', null: false
    t.index ['application_id'], name: 'index_oauth_access_tokens_on_application_id'
    t.index ['refresh_token'], name: 'index_oauth_access_tokens_on_refresh_token', unique: true
    t.index ['resource_owner_id'], name: 'index_oauth_access_tokens_on_resource_owner_id'
    t.index ['token'], name: 'index_oauth_access_tokens_on_token', unique: true
  end

  create_table 'oauth_applications', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'uid', null: false
    t.string 'secret', null: false
    t.text 'redirect_uri', null: false
    t.string 'scopes', default: '', null: false
    t.boolean 'confidential', default: true, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['uid'], name: 'index_oauth_applications_on_uid', unique: true
  end

  create_table 'questions', force: :cascade do |t|
    t.string 'title', null: false
    t.text 'body', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'author_id', null: false
    t.index ['author_id'], name: 'index_questions_on_author_id'
  end

  create_table 'subscriptions', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'question_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['question_id'], name: 'index_subscriptions_on_question_id'
    t.index %w[user_id question_id], name: 'index_subscriptions_on_user_id_and_question_id', unique: true
    t.index ['user_id'], name: 'index_subscriptions_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'admin', default: false, null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  create_table 'votes', force: :cascade do |t|
    t.string 'votable_type', null: false
    t.bigint 'votable_id', null: false
    t.bigint 'user_id', null: false
    t.integer 'point', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[user_id votable_type votable_id], name: 'index_votes_on_user_id_and_votable_type_and_votable_id'
    t.index ['user_id'], name: 'index_votes_on_user_id'
    t.index %w[votable_type votable_id], name: 'index_votes_on_votable'
  end

  add_foreign_key 'achievements', 'questions'
  add_foreign_key 'achievements', 'users', column: 'winner_id'
  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'answers', 'questions'
  add_foreign_key 'answers', 'users', column: 'author_id'
  add_foreign_key 'comments', 'users', column: 'author_id'
  add_foreign_key 'oauth_access_grants', 'oauth_applications', column: 'application_id'
  add_foreign_key 'oauth_access_tokens', 'oauth_applications', column: 'application_id'
  add_foreign_key 'questions', 'users', column: 'author_id'
  add_foreign_key 'subscriptions', 'questions'
  add_foreign_key 'subscriptions', 'users'
  add_foreign_key 'votes', 'users'
end
