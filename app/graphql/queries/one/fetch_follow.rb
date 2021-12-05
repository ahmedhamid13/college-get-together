# frozen_string_literal: true

module Queries::One
  class FetchFollow < Queries::BaseQuery
    type Types::FollowType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      Follow.find(id)
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new("Follow does not exist.")
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
        " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
