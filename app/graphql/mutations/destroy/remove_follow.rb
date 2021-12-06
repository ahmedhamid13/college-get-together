# frozen_string_literal: true

module Mutations::Destroy
  class RemoveFollow < Mutations::BaseMutation
    argument :id, ID, required: true
    field :follow, Types::FollowType, null: false

    def resolve(id:)
      follow = Follow.find(id)
      follow.destroy
      { follow: follow }
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new("Follow does not exist.")
    end
  end
end
