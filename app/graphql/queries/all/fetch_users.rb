# frozen_string_literal: true

module Queries::All
  class FetchUsers < Queries::BaseQuery
    type [Types::UserType], null: false

    def resolve
      User.all.order(created_at: :desc)
    end
  end
end
