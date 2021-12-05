# frozen_string_literal: true

module Queries::All
  class FetchFollows < Queries::BaseQuery
    type [Types::FollowType], null: false

    def resolve
      Follow.all.order(created_at: :desc)
    end
  end
end
