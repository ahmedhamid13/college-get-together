# frozen_string_literal: true

module Types::Inputs
  class LikeInputType < Types::BaseInputObject
    argument :is_like, Boolean, required: true
    argument :post_id, ID, required: true
    argument :user_id, ID, required: true
  end
end
