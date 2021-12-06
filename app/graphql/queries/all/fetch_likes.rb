# frozen_string_literal: true

module Queries::All
  class FetchLikes < Queries::BaseQuery
    type [Types::LikeType], null: false

    def resolve
      Like.all.desc
    end
  end
end
