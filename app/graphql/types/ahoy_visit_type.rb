# frozen_string_literal: true

module Types
  class AhoyVisitType < Types::BaseObject
    field :id, ID, null: false
    field :visit_token, String, null: true
    field :visitor_token, String, null: true
    field :user_id, ID, null: true
    field :ip, String, null: true
    field :user_agent, String, null: true
    field :referrer, String, null: true
    field :referring_domain, String, null: true
    field :landing_page, String, null: true
    field :browser, String, null: true
    field :os, String, null: true
    field :device_type, String, null: true
    field :country, String, null: true
    field :region, String, null: true
    field :city, String, null: true
    field :latitude, Float, null: true
    field :longitude, Float, null: true
    field :utm_source, String, null: true
    field :utm_medium, String, null: true
    field :utm_term, String, null: true
    field :utm_content, String, null: true
    field :utm_campaign, String, null: true
    field :app_version, String, null: true
    field :os_version, String, null: true
    field :platform, String, null: true
    field :started_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
