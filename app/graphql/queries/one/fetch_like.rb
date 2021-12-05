# frozen_string_literal: true

module Queries::One
  class FetchLike < Queries::BaseQuery
    type Types::LikeType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      Like.find(id)
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new("Like does not exist.")
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
        " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
