# frozen_string_literal: true

module Queries
  class FactoryQueries < Queries::BaseQuery
    type [Types::FactoryType], null: false

    argument :id, ID, required: false
    argument :offset, Integer, required: false, default_value: 0 # skips first n objects
    argument :limit, Integer, required: false, default_value: 10 # limits n objects

    def resolve(offset:, limit:, id: nil)
      return resolve_single(id: id) if id

      scope = Factory.all.order(:id)

      limit == 0 ? scope : scope.limit(limit).offset(offset)
    end

    def resolve_single(id: nil)
      return Array(Factory.find(id)) if id
    rescue ActiveRecord::RecordNotFound
      raise GraphQL::ExecutionError, "Factory not found"
    end
  end
end
