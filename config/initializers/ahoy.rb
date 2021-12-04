# frozen_string_literal: true

module Ahoy
  class Store < Ahoy::DatabaseStore
  end
end

# set to true for JavaScript tracking
Ahoy.api = true

# set to true for geocoding (and add the geocoder gem to your Gemfile)
# we recommend configuring local geocoding as well
# see https://github.com/ankane/ahoy#geocoding
Ahoy.geocode = true
Ahoy.job_queue = :normal_priority
Ahoy.server_side_visits = :when_needed
Ahoy.visit_duration = 30.minutes
Ahoy.cookie_domain = :all
