# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :desc, -> { order(created_at: :desc) }
  scope :asc, -> { order(created_at: :asc) }

  def can_manage
    false
  end
end
