# frozen_string_literal: true

module Types::Inputs
  class CommentInputType < Types::BaseInputObject
    argument :body, String, required: true
    argument :post_id, ID, required: true
    argument :user_id, ID, required: true
  end
end
