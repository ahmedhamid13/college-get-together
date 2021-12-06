# frozen_string_literal: true

module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :body, String, null: true
    field :user, Types::UserType, null: false
    field :comments, [Types::CommentType], null: true
    field :likes, [Types::LikeType], null: true
    field :user_id, ID, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :ahoy_visit_id, ID, null: true
    field :comments_count, Integer, null: false
    field :likes_count, Integer, null: false

    def comments_count
        object.comments.size
    end

    def likes_count
        object.likes.size
    end
  end
end
