# frozen_string_literal: true

module Mutations::Update
  class ModifyLike < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :params, Types::Inputs::LikeInputType, required: true
    field :like, Types::LikeType, null: false

    def resolve(id:, params:)
      like_params = Hash params

      begin
        like = Like.find(id)
        like.update!(like_params)
        { like: like }
      rescue ActiveRecord::RecordNotFound => _e
        GraphQL::ExecutionError.new("Like does not exist.")
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
