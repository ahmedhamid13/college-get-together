# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :encrypted_password, String, null: false
    field :reset_password_token, String, null: true
    field :reset_password_sent_at, GraphQL::Types::ISO8601DateTime, null: true
    field :remember_created_at, GraphQL::Types::ISO8601DateTime, null: true
    field :sign_in_count, Integer, null: false
    field :current_sign_in_at, GraphQL::Types::ISO8601DateTime, null: true
    field :last_sign_in_at, GraphQL::Types::ISO8601DateTime, null: true
    field :current_sign_in_ip, String, null: true
    field :last_sign_in_ip, String, null: true
    field :name, String, null: true
    field :image, String, null: true
    field :user_role, Integer, null: false
    field :is_super_admin, Boolean, null: false
    field :active, Boolean, null: true
    field :followers, [Types::UserType], null: true
    field :follows, [Types::UserType], null: true
    field :posts, [Types::PostType], null: true
    field :comments, [Types::CommentType], null: true
    field :likes, [Types::LikeType], null: true
    field :deleted_at, GraphQL::Types::ISO8601DateTime, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :ahoy_visit_id, ID, null: true
    field :slug, String, null: true
    field :followers_count, Integer, null: false
    field :follows_count, Integer, null: false
    field :posts_count, Integer, null: false
    field :comments_count, Integer, null: false
    field :likes_count, Integer, null: false

    def followers_count
      object.followers.size
    end

    def follows_count
      object.follows.size
    end

    def posts_count
      object.posts.size
    end

    def comments_count
      object.comments.size
    end

    def likes_count
      object.likes.size
    end
  end
end
