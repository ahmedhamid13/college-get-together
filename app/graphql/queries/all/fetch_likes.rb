# frozen_string_literal: true

module Queries::All
  class FetchLikes < Queries::BaseQuery
    type [Types::LikeType], null: false

    def resolve
      Like.all.order(created_at: :desc)
    end
  end
end
