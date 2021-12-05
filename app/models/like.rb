# frozen_string_literal: true

class Like < ApplicationRecord
  visitable :ahoy_visit

  belongs_to :user
  belongs_to :post
  validates_presence_of :user, :post
  validates :user, uniqueness: { scope: :post }

  scope :is_likes, -> { where(is_like: true) }
  scope :is_dislikes, -> { where(is_like: false) }

  rails_admin do
    object_label_method do
      :is_like
    end

    list do
      field :id
      field :is_like
      field :user
      field :post
      field :created_at
      field :updated_at
    end

    show do
      field :id
      field :is_like
      field :user
      field :post
      field :created_at
      field :updated_at
    end

    create do
      field :is_like
      field :user
      field :post
    end

    update do
      field :is_like
      field :user
      field :post
    end
  end
end
