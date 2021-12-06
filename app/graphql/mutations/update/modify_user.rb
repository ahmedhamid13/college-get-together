# frozen_string_literal: true

module Mutations::Update
  class ModifyUser < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :params, Types::Inputs::UserInputType, required: true
    field :user, Types::UserType, null: false

    def resolve(id:, params:)
      user_params = Hash params

      begin
        user = User.find(id)
        user.update!(user_params)
        { user: user }
      rescue ActiveRecord::RecordNotFound => _e
        GraphQL::ExecutionError.new("User does not exist.")
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
