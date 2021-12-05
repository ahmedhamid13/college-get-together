# frozen_string_literal: true

module Queries::One
  class FetchPost < Queries::BaseQuery
    type Types::PostType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      Post.find(id)
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new("Post does not exist.")
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
        " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
