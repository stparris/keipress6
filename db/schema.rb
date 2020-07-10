# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_27_153858) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_addresses", force: :cascade do |t|
    t.string "name"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "post_code"
    t.string "phone"
    t.string "alternative_phone"
    t.bigint "admin_id"
    t.bigint "state_id"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_admin_addresses_on_admin_id"
    t.index ["country_id"], name: "index_admin_addresses_on_country_id"
    t.index ["state_id"], name: "index_admin_addresses_on_state_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "prefix"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "suffix"
    t.string "handle"
    t.string "title"
    t.string "phone"
    t.text "bio"
    t.string "hashed_password"
    t.string "salt"
    t.integer "status"
    t.string "admin_type", null: false
    t.integer "role", default: 2
    t.string "admin_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["first_name"], name: "index_admins_on_first_name"
    t.index ["handle"], name: "index_admins_on_handle", unique: true
    t.index ["last_name"], name: "index_admins_on_last_name"
  end

  create_table "admins_sites", id: false, force: :cascade do |t|
    t.bigint "admin_id"
    t.bigint "site_id"
    t.index ["admin_id"], name: "index_admins_sites_on_admin_id"
    t.index ["site_id"], name: "index_admins_sites_on_site_id"
  end

  create_table "authors_contents", id: false, force: :cascade do |t|
    t.bigint "admin_id"
    t.bigint "content_id"
    t.index ["admin_id"], name: "index_authors_contents_on_admin_id"
    t.index ["content_id"], name: "index_authors_contents_on_content_id"
  end

  create_table "booking_transactions", force: :cascade do |t|
    t.bigint "booking_id"
    t.bigint "payment_type_id"
    t.integer "billing_address_id"
    t.integer "card_address_id"
    t.integer "amount"
    t.text "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_booking_transactions_on_booking_id"
    t.index ["payment_type_id"], name: "index_booking_transactions_on_payment_type_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.string "name"
    t.string "booking_number"
    t.bigint "site_id"
    t.bigint "user_id"
    t.bigint "event_id"
    t.bigint "tour_id"
    t.bigint "rental_id"
    t.bigint "payment_method_id"
    t.string "uuid"
    t.date "start_date"
    t.date "end_date"
    t.text "details"
    t.string "status"
    t.boolean "email_confirmed", default: false, null: false
    t.integer "guests"
    t.integer "booking_amount"
    t.integer "booking_tax"
    t.integer "booking_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_bookings_on_event_id"
    t.index ["id", "event_id"], name: "bookings_id_event_id_idx", unique: true, where: "(event_id IS NOT NULL)"
    t.index ["id", "rental_id"], name: "bookings_id_rental_id_idx", unique: true, where: "(rental_id IS NOT NULL)"
    t.index ["id", "tour_id"], name: "bookings_id_tour_id_idx", unique: true, where: "(tour_id IS NOT NULL)"
    t.index ["payment_method_id"], name: "index_bookings_on_payment_method_id"
    t.index ["rental_id"], name: "index_bookings_on_rental_id"
    t.index ["site_id"], name: "index_bookings_on_site_id"
    t.index ["tour_id"], name: "index_bookings_on_tour_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "calendars", force: :cascade do |t|
    t.string "name"
    t.bigint "site_id"
    t.string "import_url"
    t.string "export_url"
    t.text "icalendar"
    t.boolean "parent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_calendars_on_site_id"
  end

  create_table "carousel_slides", force: :cascade do |t|
    t.string "name"
    t.string "caption"
    t.text "body"
    t.bigint "image_id"
    t.bigint "carousel_id"
    t.string "css_classes"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carousel_id"], name: "index_carousel_slides_on_carousel_id"
    t.index ["image_id"], name: "index_carousel_slides_on_image_id"
  end

  create_table "carousels", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "css_classes"
    t.boolean "with_controls", default: false
    t.boolean "with_indicators", default: false
    t.boolean "with_captions", default: false
    t.boolean "with_pause", default: false
    t.boolean "with_ride", default: false
    t.integer "interval", default: 0
    t.bigint "site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "with_copyrights", default: false
    t.index ["site_id"], name: "index_carousels_on_site_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "nice_url"
    t.bigint "site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nice_url"], name: "index_categories_on_nice_url"
    t.index ["site_id"], name: "index_categories_on_site_id"
  end

  create_table "categories_contents", id: false, force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "content_id"
    t.index ["category_id"], name: "index_categories_contents_on_category_id"
    t.index ["content_id"], name: "index_categories_contents_on_content_id"
  end

  create_table "categories_images", id: false, force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "image_id"
    t.index ["category_id"], name: "index_categories_images_on_category_id"
    t.index ["image_id"], name: "index_categories_images_on_image_id"
  end

  create_table "categories_media", id: false, force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "medium_id"
    t.index ["category_id"], name: "index_categories_media_on_category_id"
    t.index ["medium_id"], name: "index_categories_media_on_medium_id"
  end

  create_table "container_rows", force: :cascade do |t|
    t.bigint "container_id"
    t.string "css_classes"
    t.integer "position"
    t.index ["container_id"], name: "index_container_rows_on_container_id"
  end

  create_table "containers", force: :cascade do |t|
    t.string "name"
    t.bigint "site_id"
    t.string "container_type", null: false
    t.bigint "navigation_id"
    t.bigint "content_id"
    t.bigint "medium_id"
    t.bigint "image_id"
    t.bigint "carousel_id"
    t.bigint "rows_flag"
    t.string "css_classes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carousel_id"], name: "index_containers_on_carousel_id"
    t.index ["content_id"], name: "index_containers_on_content_id"
    t.index ["id", "carousel_id"], name: "containers_id_carousel_id_idx", unique: true, where: "(carousel_id IS NOT NULL)"
    t.index ["id", "content_id"], name: "containers_id_content_id_idx", unique: true, where: "(content_id IS NOT NULL)"
    t.index ["id", "image_id"], name: "containers_id_image_id_idx", unique: true, where: "(image_id IS NOT NULL)"
    t.index ["id", "medium_id"], name: "containers_id_medium_id_idx", unique: true, where: "(medium_id IS NOT NULL)"
    t.index ["id", "navigation_id"], name: "containers_id_navigation_id_idx", unique: true, where: "(navigation_id IS NOT NULL)"
    t.index ["id", "rows_flag"], name: "containers_id_rows_flag_idx", unique: true, where: "(rows_flag IS NOT NULL)"
    t.index ["image_id"], name: "index_containers_on_image_id"
    t.index ["medium_id"], name: "index_containers_on_medium_id"
    t.index ["navigation_id"], name: "index_containers_on_navigation_id"
    t.index ["site_id"], name: "index_containers_on_site_id"
  end

  create_table "containers_pages", force: :cascade do |t|
    t.bigint "container_id"
    t.bigint "page_id"
    t.integer "position"
    t.index ["container_id"], name: "index_containers_pages_on_container_id"
    t.index ["page_id"], name: "index_containers_pages_on_page_id"
  end

  create_table "content_items", force: :cascade do |t|
    t.string "name"
    t.string "type", null: false
    t.string "css_classes"
    t.bigint "content_id"
    t.string "content_type", null: false
    t.bigint "image_id"
    t.bigint "carousel_id"
    t.bigint "image_group_id"
    t.bigint "medium_id"
    t.bigint "list_group_id"
    t.bigint "link_text_id"
    t.bigint "text_html_flag"
    t.text "body"
    t.bigint "admin_id"
    t.boolean "include_admin_handle", default: false
    t.boolean "include_update_time", default: false
    t.boolean "include_caption", default: false
    t.boolean "include_copyright", default: false
    t.boolean "include_description", default: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_content_items_on_admin_id"
    t.index ["carousel_id"], name: "index_content_items_on_carousel_id"
    t.index ["content_id"], name: "index_content_items_on_content_id"
    t.index ["id", "carousel_id"], name: "content_items_id_carousel_id_idx", unique: true, where: "(carousel_id IS NOT NULL)"
    t.index ["id", "image_group_id"], name: "content_items_id_image_group_id_idx", unique: true, where: "(image_group_id IS NOT NULL)"
    t.index ["id", "image_id"], name: "content_items_id_image_id_idx", unique: true, where: "(image_id IS NOT NULL)"
    t.index ["id", "link_text_id"], name: "content_items_id_link_text_id_idx", unique: true, where: "(link_text_id IS NOT NULL)"
    t.index ["id", "list_group_id"], name: "content_items_id_list_group_id_idx", unique: true, where: "(list_group_id IS NOT NULL)"
    t.index ["id", "medium_id"], name: "content_items_id_medium_id_idx", unique: true, where: "(medium_id IS NOT NULL)"
    t.index ["id", "text_html_flag"], name: "content_items_id_text_html_flag_idx", unique: true, where: "(text_html_flag IS NOT NULL)"
    t.index ["image_group_id"], name: "index_content_items_on_image_group_id"
    t.index ["image_id"], name: "index_content_items_on_image_id"
    t.index ["link_text_id"], name: "index_content_items_on_link_text_id"
    t.index ["list_group_id"], name: "index_content_items_on_list_group_id"
    t.index ["medium_id"], name: "index_content_items_on_medium_id"
  end

  create_table "contents", force: :cascade do |t|
    t.bigint "site_id"
    t.string "name"
    t.string "css_classes"
    t.string "type"
    t.boolean "published"
    t.bigint "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_contents_on_admin_id"
    t.index ["site_id"], name: "index_contents_on_site_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "iso_name"
    t.string "iso"
    t.string "iso3"
    t.integer "numcode"
    t.boolean "state_required"
    t.boolean "post_code_required"
    t.boolean "eu"
    t.index ["name"], name: "index_countries_on_name"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "domains", force: :cascade do |t|
    t.string "name"
    t.bigint "site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_domains_on_name", unique: true
    t.index ["site_id"], name: "index_domains_on_site_id"
  end

  create_table "dropdown_items", force: :cascade do |t|
    t.string "name"
    t.string "label"
    t.bigint "dropdown_id"
    t.string "css_classes"
    t.string "item_type", null: false
    t.bigint "page_id"
    t.bigint "category_id"
    t.bigint "link_text_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_dropdown_items_on_category_id"
    t.index ["dropdown_id"], name: "index_dropdown_items_on_dropdown_id"
    t.index ["id", "category_id"], name: "dropdown_items_id_category_id_idx", unique: true, where: "(category_id IS NOT NULL)"
    t.index ["id", "link_text_id"], name: "dropdown_items_id_link_text_id_idx", unique: true, where: "(link_text_id IS NOT NULL)"
    t.index ["id", "page_id"], name: "dropdown_items_id_page_id_idx", unique: true, where: "(page_id IS NOT NULL)"
    t.index ["link_text_id"], name: "index_dropdown_items_on_link_text_id"
    t.index ["page_id"], name: "index_dropdown_items_on_page_id"
  end

  create_table "dropdowns", force: :cascade do |t|
    t.string "name"
    t.bigint "site_id"
    t.string "css_classes"
    t.string "nav_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_dropdowns_on_site_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.bigint "site_id"
    t.bigint "calendar_id"
    t.date "start_date"
    t.date "end_date"
    t.string "currency"
    t.integer "regular_rate"
    t.integer "other_fees", default: 0
    t.decimal "tax_rate", precision: 5, scale: 4, default: "0.0"
    t.text "description"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["calendar_id"], name: "index_events_on_calendar_id"
    t.index ["site_id"], name: "index_events_on_site_id"
  end

  create_table "image_batch_images", force: :cascade do |t|
    t.bigint "image_batch_id"
    t.bigint "image_id"
    t.boolean "published", default: false, null: false
    t.index ["image_batch_id"], name: "index_image_batch_images_on_image_batch_id"
    t.index ["image_id"], name: "index_image_batch_images_on_image_id"
  end

  create_table "image_batches", force: :cascade do |t|
    t.string "name"
    t.string "caption"
    t.integer "copyright_year"
    t.string "copyright_by"
    t.string "naming_method"
    t.string "naming_prefix"
    t.integer "naming_sequence", default: 1
    t.text "description"
    t.integer "quality"
    t.boolean "publish", default: false, null: false
    t.bigint "image_group_id"
    t.bigint "category_id"
    t.bigint "site_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_image_batches_on_category_id"
    t.index ["image_group_id"], name: "index_image_batches_on_image_group_id"
    t.index ["site_id"], name: "index_image_batches_on_site_id"
  end

  create_table "image_group_items", force: :cascade do |t|
    t.bigint "image_group_id"
    t.bigint "image_id"
    t.string "css_classes"
    t.integer "position"
    t.string "name"
    t.string "caption"
    t.text "body"
    t.index ["image_group_id"], name: "index_image_group_items_on_image_group_id"
    t.index ["image_id"], name: "index_image_group_items_on_image_id"
  end

  create_table "image_groups", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "css_classes"
    t.string "image_group_type"
    t.bigint "site_id"
    t.bigint "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "include_caption", default: false
    t.boolean "include_copyright", default: false
    t.boolean "include_body", default: false
    t.index ["image_id"], name: "index_image_groups_on_image_id"
    t.index ["site_id"], name: "index_image_groups_on_site_id"
  end

  create_table "image_previews", force: :cascade do |t|
    t.bigint "image_id"
    t.integer "parent_id", default: 0
    t.string "preview_type"
    t.string "source_file"
    t.string "content_type"
    t.integer "size", default: 0
    t.integer "width", default: 0
    t.integer "height", default: 0
    t.integer "quality", default: 100
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["image_id"], name: "index_image_previews_on_image_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "name"
    t.string "caption"
    t.integer "copyright_year"
    t.string "copyright_by"
    t.text "description"
    t.bigint "site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "max_width"
    t.string "quality"
    t.index ["site_id"], name: "index_images_on_site_id"
  end

  create_table "link_texts", force: :cascade do |t|
    t.bigint "site_id"
    t.string "link"
    t.text "body"
    t.string "test_text"
    t.boolean "new_window", default: false
    t.string "css_classes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_link_texts_on_site_id"
  end

  create_table "list_group_items", force: :cascade do |t|
    t.string "name"
    t.string "label"
    t.string "css_classes"
    t.string "item_type", null: false
    t.bigint "list_group_id"
    t.bigint "link_text_id"
    t.bigint "page_id"
    t.bigint "category_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_list_group_items_on_category_id"
    t.index ["id", "category_id"], name: "list_group_items_id_category_id_idx", unique: true, where: "(category_id IS NOT NULL)"
    t.index ["id", "link_text_id"], name: "list_group_items_id_link_text_id_idx", unique: true, where: "(link_text_id IS NOT NULL)"
    t.index ["id", "page_id"], name: "list_group_items_id_page_id_idx", unique: true, where: "(page_id IS NOT NULL)"
    t.index ["link_text_id"], name: "index_list_group_items_on_link_text_id"
    t.index ["list_group_id"], name: "index_list_group_items_on_list_group_id"
    t.index ["page_id"], name: "index_list_group_items_on_page_id"
  end

  create_table "list_groups", force: :cascade do |t|
    t.string "name"
    t.bigint "site_id"
    t.string "css_classes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_list_groups_on_site_id"
  end

  create_table "mail_servers", force: :cascade do |t|
    t.string "name"
    t.bigint "site_id"
    t.string "gateway_type"
    t.json "config"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_mail_servers_on_site_id"
  end

  create_table "mail_templates", force: :cascade do |t|
    t.string "name"
    t.bigint "site_id"
    t.string "from_email"
    t.string "subject"
    t.string "recipient_type"
    t.string "template_type"
    t.string "locale"
    t.string "body_html"
    t.string "body_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_mail_templates_on_site_id"
  end

  create_table "media", force: :cascade do |t|
    t.string "name"
    t.string "type", null: false
    t.string "caption"
    t.integer "copyright_year"
    t.string "copyright_by"
    t.text "description"
    t.bigint "image_id"
    t.bigint "site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_id"], name: "index_media_on_image_id"
    t.index ["site_id"], name: "index_media_on_site_id"
  end

  create_table "navigation_items", force: :cascade do |t|
    t.string "name"
    t.string "label"
    t.bigint "navigation_id"
    t.string "css_classes"
    t.string "item_type", null: false
    t.bigint "page_id"
    t.bigint "category_id"
    t.bigint "dropdown_id"
    t.bigint "link_text_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_navigation_items_on_category_id"
    t.index ["dropdown_id"], name: "index_navigation_items_on_dropdown_id"
    t.index ["id", "category_id"], name: "navigation_items_id_category_id_idx", unique: true, where: "(category_id IS NOT NULL)"
    t.index ["id", "dropdown_id"], name: "navigation_items_id_dropdown_id_idx", unique: true, where: "(dropdown_id IS NOT NULL)"
    t.index ["id", "link_text_id"], name: "navigation_items_id_link_text_id_idx", unique: true, where: "(link_text_id IS NOT NULL)"
    t.index ["id", "page_id"], name: "navigation_items_id_page_id_idx", unique: true, where: "(page_id IS NOT NULL)"
    t.index ["link_text_id"], name: "index_navigation_items_on_link_text_id"
    t.index ["navigation_id"], name: "index_navigation_items_on_navigation_id"
    t.index ["page_id"], name: "index_navigation_items_on_page_id"
  end

  create_table "navigations", force: :cascade do |t|
    t.string "name"
    t.bigint "site_id"
    t.string "main_css_classes"
    t.string "list_css_classes"
    t.string "nav_type", null: false
    t.text "brand"
    t.text "form"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_navigations_on_site_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "name"
    t.string "nice_url"
    t.text "description"
    t.string "assignment"
    t.integer "site_id"
    t.integer "theme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment"], name: "index_pages_on_assignment"
    t.index ["nice_url"], name: "index_pages_on_nice_url"
    t.index ["site_id"], name: "index_pages_on_site_id"
  end

  create_table "palette_colors", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.bigint "palette_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["palette_id"], name: "index_palette_colors_on_palette_id"
  end

  create_table "palettes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_gateways", force: :cascade do |t|
    t.string "name"
    t.bigint "site_id"
    t.string "mode"
    t.string "gateway_type"
    t.json "config"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_payment_gateways_on_site_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name"
    t.string "locale"
    t.bigint "site_id"
    t.bigint "payment_type_id"
    t.boolean "active", default: true, null: false
    t.string "button_text"
    t.text "instructions"
    t.text "summary_page_html"
    t.integer "user_mail_template_id"
    t.integer "admin_mail_template_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_type_id"], name: "index_payment_methods_on_payment_type_id"
    t.index ["site_id"], name: "index_payment_methods_on_site_id"
  end

  create_table "payment_types", force: :cascade do |t|
    t.string "name"
    t.string "payment_type"
    t.bigint "site_id"
    t.bigint "payment_gateway_id"
    t.boolean "show_email", default: true, null: false
    t.boolean "require_email", default: true, null: false
    t.boolean "show_user_names", default: false, null: false
    t.boolean "require_user_names", default: false, null: false
    t.boolean "show_primary_address", default: false, null: false
    t.boolean "require_card_address", default: false, null: false
    t.boolean "require_billing_address", default: false, null: false
    t.boolean "require_shipping_address", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_gateway_id"], name: "index_payment_types_on_payment_gateway_id"
    t.index ["site_id"], name: "index_payment_types_on_site_id"
  end

  create_table "rental_booking_instructions", force: :cascade do |t|
    t.string "name"
    t.string "css_classes"
    t.string "locale"
    t.string "regular_rate_instructions"
    t.string "discount_rate_instructions"
    t.text "booking_instructions"
    t.text "payment_instructions"
    t.string "booking_button_text"
    t.bigint "rental_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rental_id"], name: "index_rental_booking_instructions_on_rental_id"
  end

  create_table "rental_payment_methods", force: :cascade do |t|
    t.bigint "payment_method_id"
    t.bigint "rental_id"
    t.integer "position"
    t.index ["payment_method_id"], name: "index_rental_payment_methods_on_payment_method_id"
    t.index ["rental_id"], name: "index_rental_payment_methods_on_rental_id"
  end

  create_table "rentals", force: :cascade do |t|
    t.string "name"
    t.bigint "site_id"
    t.bigint "calendar_id"
    t.integer "min_days"
    t.integer "max_days"
    t.integer "min_guests"
    t.integer "max_guests"
    t.string "currency"
    t.integer "regular_rate"
    t.integer "discount_rate"
    t.integer "extras_rate"
    t.integer "extras_discount_rate"
    t.integer "other_fees", default: 0
    t.string "regular_dates"
    t.string "discount_dates"
    t.decimal "tax_rate", precision: 5, scale: 4, default: "0.0", null: false
    t.decimal "deposit_percent", precision: 5, scale: 4, default: "0.0", null: false
    t.integer "deposit_days", default: 0
    t.integer "cancellation_days", default: 0
    t.text "description"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["calendar_id"], name: "index_rentals_on_calendar_id"
    t.index ["site_id"], name: "index_rentals_on_site_id"
  end

  create_table "row_columns", force: :cascade do |t|
    t.bigint "container_row_id"
    t.string "css_classes"
    t.string "content_type"
    t.bigint "content_id"
    t.bigint "category_id"
    t.bigint "image_group_id"
    t.bigint "carousel_id"
    t.bigint "list_group_id"
    t.integer "position"
    t.index ["carousel_id"], name: "index_row_columns_on_carousel_id"
    t.index ["category_id"], name: "index_row_columns_on_category_id"
    t.index ["container_row_id"], name: "index_row_columns_on_container_row_id"
    t.index ["content_id"], name: "index_row_columns_on_content_id"
    t.index ["id", "carousel_id"], name: "row_columns_id_carousel_id_idx", unique: true, where: "(carousel_id IS NOT NULL)"
    t.index ["id", "category_id"], name: "row_columns_id_category_id_idx", unique: true, where: "(category_id IS NOT NULL)"
    t.index ["id", "content_id"], name: "row_columns_id_content_id_idx", unique: true, where: "(content_id IS NOT NULL)"
    t.index ["id", "image_group_id"], name: "row_columns_id_image_group_id_idx", unique: true, where: "(image_group_id IS NOT NULL)"
    t.index ["id", "list_group_id"], name: "row_columns_id_list_group_id_idx", unique: true, where: "(list_group_id IS NOT NULL)"
    t.index ["image_group_id"], name: "index_row_columns_on_image_group_id"
    t.index ["list_group_id"], name: "index_row_columns_on_list_group_id"
  end

  create_table "site_includes", force: :cascade do |t|
    t.string "name"
    t.bigint "site_id"
    t.bigint "page_id"
    t.index ["page_id"], name: "index_site_includes_on_page_id"
    t.index ["site_id"], name: "index_site_includes_on_site_id"
  end

  create_table "site_tags", force: :cascade do |t|
    t.bigint "site_id"
    t.string "name"
    t.string "tag_type"
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["site_id"], name: "index_site_tags_on_site_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "keywords"
    t.string "favicon"
    t.string "analytics"
    t.string "time_zone"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_sites_on_country_id"
    t.index ["name"], name: "index_sites_on_name", unique: true
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "abbr"
    t.bigint "country_id"
    t.index ["country_id"], name: "index_states_on_country_id"
  end

  create_table "theme_colors", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.bigint "theme_id"
    t.bigint "palette_color_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["palette_color_id"], name: "index_theme_colors_on_palette_color_id"
    t.index ["theme_id"], name: "index_theme_colors_on_theme_id"
  end

  create_table "themes", force: :cascade do |t|
    t.string "name"
    t.string "css_class"
    t.text "scss_production"
    t.text "scss_workspace"
    t.bigint "site_id"
    t.bigint "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_themes_on_admin_id"
    t.index ["site_id"], name: "index_themes_on_site_id"
  end

  create_table "tours", force: :cascade do |t|
    t.string "name"
    t.bigint "site_id"
    t.bigint "calendar_id"
    t.integer "min_guests"
    t.integer "max_guests"
    t.string "currency"
    t.integer "regular_rate"
    t.integer "discount_rate"
    t.integer "extras_rate"
    t.integer "extras_discount_rate"
    t.integer "other_fees", default: 0
    t.string "regular_dates"
    t.string "discount_dates"
    t.decimal "tax_rate", precision: 5, scale: 4, default: "0.0"
    t.decimal "deposit_percent", precision: 5, scale: 4, default: "0.0"
    t.integer "deposit_days", default: 0
    t.integer "cancellation_days", default: 0
    t.text "description"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["calendar_id"], name: "index_tours_on_calendar_id"
    t.index ["site_id"], name: "index_tours_on_site_id"
  end

  create_table "user_addresses", force: :cascade do |t|
    t.string "name"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "post_code"
    t.string "phone"
    t.string "alternative_phone"
    t.bigint "user_id"
    t.bigint "state_id"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_user_addresses_on_country_id"
    t.index ["state_id"], name: "index_user_addresses_on_state_id"
    t.index ["user_id"], name: "index_user_addresses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "prefix"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "suffix"
    t.string "locale"
    t.string "hashed_password"
    t.string "salt"
    t.string "title"
    t.string "auth_code"
    t.string "auth_code_expiration"
    t.string "marketing"
    t.string "user_token"
    t.bigint "site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["first_name"], name: "index_users_on_first_name"
    t.index ["last_name"], name: "index_users_on_last_name"
    t.index ["site_id"], name: "index_users_on_site_id"
  end

  add_foreign_key "admin_addresses", "admins", on_delete: :cascade
  add_foreign_key "admin_addresses", "countries", on_delete: :nullify
  add_foreign_key "admin_addresses", "states", on_delete: :nullify
  add_foreign_key "admins_sites", "admins", on_delete: :cascade
  add_foreign_key "admins_sites", "sites", on_delete: :cascade
  add_foreign_key "authors_contents", "admins", on_delete: :cascade
  add_foreign_key "authors_contents", "contents", on_delete: :cascade
  add_foreign_key "booking_transactions", "bookings", on_delete: :cascade
  add_foreign_key "booking_transactions", "payment_types", on_delete: :nullify
  add_foreign_key "booking_transactions", "user_addresses", column: "billing_address_id", on_delete: :nullify
  add_foreign_key "booking_transactions", "user_addresses", column: "card_address_id", on_delete: :nullify
  add_foreign_key "bookings", "events", on_delete: :cascade
  add_foreign_key "bookings", "payment_methods", on_delete: :nullify
  add_foreign_key "bookings", "rentals", on_delete: :cascade
  add_foreign_key "bookings", "sites", on_delete: :cascade
  add_foreign_key "bookings", "tours", on_delete: :cascade
  add_foreign_key "bookings", "users", on_delete: :cascade
  add_foreign_key "calendars", "sites", on_delete: :cascade
  add_foreign_key "carousel_slides", "carousels", on_delete: :cascade
  add_foreign_key "carousel_slides", "images", on_delete: :nullify
  add_foreign_key "carousels", "sites", on_delete: :cascade
  add_foreign_key "categories", "sites", on_delete: :cascade
  add_foreign_key "categories_contents", "categories", on_delete: :cascade
  add_foreign_key "categories_contents", "contents", on_delete: :cascade
  add_foreign_key "categories_images", "categories", on_delete: :cascade
  add_foreign_key "categories_images", "images", on_delete: :cascade
  add_foreign_key "categories_media", "categories", on_delete: :cascade
  add_foreign_key "categories_media", "media", on_delete: :cascade
  add_foreign_key "container_rows", "containers", on_delete: :cascade
  add_foreign_key "containers", "carousels", on_delete: :cascade
  add_foreign_key "containers", "contents", on_delete: :cascade
  add_foreign_key "containers", "images", on_delete: :cascade
  add_foreign_key "containers", "media", on_delete: :cascade
  add_foreign_key "containers", "navigations", on_delete: :cascade
  add_foreign_key "containers", "sites", on_delete: :cascade
  add_foreign_key "containers_pages", "containers", on_delete: :cascade
  add_foreign_key "containers_pages", "pages", on_delete: :cascade
  add_foreign_key "content_items", "admins", on_delete: :nullify
  add_foreign_key "content_items", "carousels", on_delete: :nullify
  add_foreign_key "content_items", "contents", on_delete: :cascade
  add_foreign_key "content_items", "image_groups", on_delete: :nullify
  add_foreign_key "content_items", "images", on_delete: :nullify
  add_foreign_key "content_items", "link_texts", on_delete: :nullify
  add_foreign_key "content_items", "list_groups", on_delete: :nullify
  add_foreign_key "content_items", "media", on_delete: :nullify
  add_foreign_key "contents", "admins", on_delete: :nullify
  add_foreign_key "contents", "sites", on_delete: :cascade
  add_foreign_key "domains", "sites", on_delete: :cascade
  add_foreign_key "dropdown_items", "categories", on_delete: :cascade
  add_foreign_key "dropdown_items", "dropdowns", on_delete: :cascade
  add_foreign_key "dropdown_items", "link_texts", on_delete: :cascade
  add_foreign_key "dropdown_items", "pages", on_delete: :cascade
  add_foreign_key "dropdowns", "sites", on_delete: :cascade
  add_foreign_key "events", "calendars", on_delete: :nullify
  add_foreign_key "events", "sites", on_delete: :cascade
  add_foreign_key "image_batch_images", "image_batches", on_delete: :cascade
  add_foreign_key "image_batch_images", "images", on_delete: :cascade
  add_foreign_key "image_batches", "categories", on_delete: :nullify
  add_foreign_key "image_batches", "image_groups", on_delete: :nullify
  add_foreign_key "image_batches", "sites", on_delete: :cascade
  add_foreign_key "image_group_items", "image_groups", on_delete: :cascade
  add_foreign_key "image_group_items", "images", on_delete: :cascade
  add_foreign_key "image_groups", "images", on_delete: :nullify
  add_foreign_key "image_groups", "sites", on_delete: :cascade
  add_foreign_key "image_previews", "images", on_delete: :cascade
  add_foreign_key "images", "sites", on_delete: :cascade
  add_foreign_key "link_texts", "sites", on_delete: :cascade
  add_foreign_key "list_group_items", "categories", on_delete: :cascade
  add_foreign_key "list_group_items", "link_texts", on_delete: :cascade
  add_foreign_key "list_group_items", "list_groups", on_delete: :cascade
  add_foreign_key "list_group_items", "pages", on_delete: :cascade
  add_foreign_key "list_groups", "sites", on_delete: :cascade
  add_foreign_key "mail_servers", "sites", on_delete: :cascade
  add_foreign_key "mail_templates", "sites", on_delete: :cascade
  add_foreign_key "media", "images", on_delete: :nullify
  add_foreign_key "media", "sites", on_delete: :cascade
  add_foreign_key "navigation_items", "categories", on_delete: :cascade
  add_foreign_key "navigation_items", "dropdowns", on_delete: :cascade
  add_foreign_key "navigation_items", "link_texts", on_delete: :cascade
  add_foreign_key "navigation_items", "navigations", on_delete: :cascade
  add_foreign_key "navigation_items", "pages", on_delete: :cascade
  add_foreign_key "navigations", "sites", on_delete: :cascade
  add_foreign_key "pages", "sites", on_delete: :cascade
  add_foreign_key "pages", "themes", on_delete: :nullify
  add_foreign_key "palette_colors", "palettes", on_delete: :cascade
  add_foreign_key "payment_gateways", "sites", on_delete: :cascade
  add_foreign_key "payment_methods", "mail_templates", column: "admin_mail_template_id", on_delete: :nullify
  add_foreign_key "payment_methods", "mail_templates", column: "user_mail_template_id", on_delete: :nullify
  add_foreign_key "payment_methods", "payment_types", on_delete: :cascade
  add_foreign_key "payment_methods", "sites", on_delete: :cascade
  add_foreign_key "payment_types", "payment_gateways", on_delete: :nullify
  add_foreign_key "payment_types", "sites", on_delete: :cascade
  add_foreign_key "rental_booking_instructions", "rentals", on_delete: :cascade
  add_foreign_key "rental_payment_methods", "payment_methods", on_delete: :cascade
  add_foreign_key "rental_payment_methods", "rentals", on_delete: :cascade
  add_foreign_key "rentals", "calendars", on_delete: :nullify
  add_foreign_key "rentals", "sites", on_delete: :cascade
  add_foreign_key "row_columns", "carousels", on_delete: :nullify
  add_foreign_key "row_columns", "categories", on_delete: :nullify
  add_foreign_key "row_columns", "container_rows", on_delete: :cascade
  add_foreign_key "row_columns", "contents", on_delete: :nullify
  add_foreign_key "row_columns", "image_groups", on_delete: :nullify
  add_foreign_key "row_columns", "list_groups", on_delete: :nullify
  add_foreign_key "site_includes", "pages", on_delete: :nullify
  add_foreign_key "site_includes", "sites", on_delete: :nullify
  add_foreign_key "site_tags", "sites", on_delete: :cascade
  add_foreign_key "sites", "countries", on_delete: :nullify
  add_foreign_key "states", "countries", on_delete: :cascade
  add_foreign_key "theme_colors", "palette_colors", on_delete: :cascade
  add_foreign_key "theme_colors", "themes", on_delete: :cascade
  add_foreign_key "themes", "admins", on_delete: :nullify
  add_foreign_key "themes", "sites", on_delete: :cascade
  add_foreign_key "tours", "calendars", on_delete: :nullify
  add_foreign_key "tours", "sites", on_delete: :cascade
  add_foreign_key "user_addresses", "countries", on_delete: :nullify
  add_foreign_key "user_addresses", "states", on_delete: :nullify
  add_foreign_key "user_addresses", "users", on_delete: :cascade
  add_foreign_key "users", "sites", on_delete: :cascade
end
