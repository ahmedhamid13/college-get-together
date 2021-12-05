# frozen_string_literal: true

module Mutations::Create
  class AddLike < Mutations::BaseMutation
    argument :params, Types::Inputs::LikeInputType, required: true
    field :like, Types::LikeType, null: false

    def resolve(params:)
      like_params = Hash params

      begin
        like = Like.create!(like_params)
        { like: like }
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
