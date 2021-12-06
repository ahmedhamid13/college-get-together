# frozen_string_literal: true

module Queries::All
  class FetchAhoyVisits < Queries::BaseQuery
    type [Types::AhoyVisitType], null: false

    def resolve
      AhoyVisit.all.desc
    end
  end
end
