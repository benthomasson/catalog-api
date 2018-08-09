=begin
Insights HSDM API

This is a API to fetch and order catalog items from different cloud sources

OpenAPI spec version: 1.0.0
Contact: you@your-company.com
Generated by: https://github.com/swagger-api/swagger-codegen.git

=end

class InitTables < ActiveRecord::Migration[5.0]
  def change
    create_table "catalog_item".pluralize.to_sym, id: false do |t|
      t.string :provider_id
      t.string :catalog_id
      t.string :name
      t.string :description
      t.string :image_url

      t.timestamps
    end

    create_table "catalog_parameter".pluralize.to_sym, id: false do |t|
      t.string :type
      t.string :title
      t.string :name
      t.string :description
      t.string :default
      t.string :pattern
      t.string :example
      t.boolean :required
      t.string :format
      t.string :enum

      t.timestamps
    end

    create_table "order".pluralize.to_sym, id: false do |t|
      t.string :id
      t.string :user_id
      t.string :state
      t.datetime :created_at
      t.datetime :ordered_at
      t.datetime :completed_at
      t.string :order_items

      t.timestamps
    end

    create_table "order_item".pluralize.to_sym, id: false do |t|
      t.string :id
      t.integer :count
      t.string :parameters
      t.string :catalog_id
      t.string :provider_id
      t.string :order_id
      t.string :state
      t.datetime :created_at
      t.datetime :ordered_at
      t.datetime :completed_at
      t.datetime :updated_at
      t.string :external_ref

      t.timestamps
    end

    create_table "parameter_value".pluralize.to_sym, id: false do |t|
      t.string :name
      t.string :value
      t.string :type
      t.string :format

      t.timestamps
    end

    create_table "progress_message".pluralize.to_sym, id: false do |t|
      t.datetime :received_at
      t.string :level
      t.string :message
      t.string :order_item_id

      t.timestamps
    end

    create_table "provider".pluralize.to_sym, id: false do |t|
      t.string :id
      t.string :name
      t.string :description
      t.string :url
      t.string :user
      t.string :password
      t.string :token
      t.boolean :verify_ssl

      t.timestamps
    end

  end
end
