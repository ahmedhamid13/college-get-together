# frozen_string_literal: true

module Queries::All
  class FetchPosts < Queries::BaseQuery
    type [Types::PostType], null: false

    def resolve
      Post.all.desc
    end
  end
end
