# frozen_string_literal: true

module Queries::All
  class FetchComments < Queries::BaseQuery
    type [Types::CommentType], null: false

    def resolve
      Comment.all.desc
    end
  end
end
