# frozen_string_literal: true

module Mutations
  class CreatePlane < BaseMutation
    argument :manufacture, String, required: true
    argument :factory_id, ID, loads: Types::FactoryType, required: true

    type Types::PlaneType

    def resolve(manufacture:, factory:)
      plane = Plane.create!(
        manufacture: manufacture, factory: factory
      )
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
