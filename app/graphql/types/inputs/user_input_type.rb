# frozen_string_literal: true

module Types::Inputs
  class UserInputType < Types::BaseInputObject
    argument :name, String, required: true
    argument :email, String, required: true
    argument :image, String, required: false
    argument :user_role, Integer, required: true
    argument :password, String, required: true
    argument :password_confirmation, String, required: true
  end
end
