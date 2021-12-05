# frozen_string_literal: true

module Queries::One
  class FetchAhoyVisit < Queries::BaseQuery
    type Types::AhoyVisitType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      AhoyVisit.find(id)
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new("AhoyVisit does not exist.")
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
        " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
