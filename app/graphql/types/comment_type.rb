# frozen_string_literal: true

module Types
  class CommentType < Types::BaseObject
    field :id, ID, null: false
    field :body, String, null: false
    field :user_id, ID, null: false
    field :post_id, ID, null: false
    field :user, Types::UserType, null: false
    field :post, Types::PostType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :ahoy_visit_id, ID, null: true
  end
end
