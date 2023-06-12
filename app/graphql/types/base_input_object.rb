# frozen_string_literal: true

module Types
  class BaseInputObject < GraphQL::Schema::InputObject
    argument_class Types::BaseArgument

    def object_from_id(type, id, ctx)
      type.object_from_id(id, ctx)
    end
  end
end
