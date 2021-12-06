# frozen_string_literal: true

module Mutations::Destroy
  class RemoveUser < Mutations::BaseMutation
    argument :id, ID, required: true
    field :user, Types::UserType, null: false

    def resolve(id:)
      user = User.find(id)
      user.destroy
      { user: user }
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new("User does not exist.")
    end
  end
end
