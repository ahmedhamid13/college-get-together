# frozen_string_literal: true

module Queries::All
  class FetchUsers < Queries::BaseQuery
    type [Types::UserType], null: false

    def resolve
      User.all.desc
    end
  end
end
