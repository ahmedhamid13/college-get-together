# frozen_string_literal: true

json.extract! follow, :id, :followed_id, :user_id, :created_at, :updated_at
json.url follow_url(follow, format: :json)
