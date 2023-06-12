# frozen_string_literal: true

module Queries
  class CarQueries < Queries::BaseQuery
    type [Types::CarType], null: false

    argument :id, ID, required: false
    argument :offset, Integer, required: false, default_value: 0
    argument :limit, Integer, required: false, default_value: 10

    def resolve(offset:, limit:, id: nil)
      return resolve_single(id: id) if id

      scope = Car.all.order(:id)

      limit == 0 ? scope : scope.limit(limit).offset(offset)
    end

    def resolve_single(id: nil)
      return Array(Car.find(id)) if id
    rescue ActiveRecord::RecordNotFound
      raise GraphQL::ExecutionError, "Car not found"
    end
  end
end
