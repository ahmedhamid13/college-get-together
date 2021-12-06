# frozen_string_literal: true

module Mutations::Update
  class ModifyFollow < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :params, Types::Inputs::FollowInputType, required: true
    field :follow, Types::FollowType, null: false

    def resolve(id:, params:)
      follow_params = Hash params

      begin
        follow = Follow.find(id)
        follow.update!(follow_params)
        { follow: follow }
      rescue ActiveRecord::RecordNotFound => _e
        GraphQL::ExecutionError.new("Follow does not exist.")
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
