# frozen_string_literal: true

module Queries
  class PlaneQueries < Queries::BaseQuery
    type [Types::PlaneType], null: false

    argument :id, ID, required: false
    argument :offset, Integer, required: false, default_value: 0 # skips first n objects
    argument :limit, Integer, required: false, default_value: 10 # limits n objects

    def resolve(offset:, limit:, id: nil)
      return resolve_single(id: id) if id

      scope = Plane.all.order(:id)

      limit == 0 ? scope : scope.limit(limit).offset(offset)
    end

    def resolve_single(id: nil)
      return Array(Plane.find(id)) if id
    rescue ActiveRecord::RecordNotFound
      raise GraphQL::ExecutionError, "Plane not found"
    end
  end
end
