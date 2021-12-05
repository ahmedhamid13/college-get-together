# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :followed, class_name: "User"
  validates_presence_of :user, :followed
  validates :user, uniqueness: { scope: :followed }


  rails_admin do
    object_label_method do
      :is_like
    end

    list do
      field :id
      field :user
      field :followed
      field :created_at
      field :updated_at
    end

    show do
      field :id
      field :user
      field :followed
      field :created_at
      field :updated_at
    end

    create do
      field :user
      field :followed
    end

    update do
      field :user
      field :followed
    end
  end
end
