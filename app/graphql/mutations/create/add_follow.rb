# frozen_string_literal: true

module Mutations::Create
  class AddFollow < Mutations::BaseMutation
    argument :params, Types::Inputs::FollowInputType, required: true
    field :follow, Types::FollowType, null: false

    def resolve(params:)
      follow_params = Hash params

      begin
        follow = Follow.create!(follow_params)
        { follow: follow }
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
