=begin
Insights HSDM API

This is a API to fetch and order catalog items from different cloud sources

OpenAPI spec version: 1.0.0
Contact: you@your-company.com
Generated by: https://github.com/swagger-api/swagger-codegen.git

=end


class OrderItem < ApplicationRecord
  validates_presence_of :count
  validates_presence_of :parameters

  serialize :parameters, Array
end
