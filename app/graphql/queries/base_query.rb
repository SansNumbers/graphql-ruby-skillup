# frozen_string_literal: true

module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    def object_from_id(type, id, ctx)
      type.object_from_id(id, ctx)
    end
  end
end
