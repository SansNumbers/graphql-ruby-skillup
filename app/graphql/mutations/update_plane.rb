# frozen_string_literal: true

module Mutations
  class UpdatePlane < BaseMutation
    argument :id, ID, loads: Types::PlaneType, as: :plane, required: true
    argument :manufacture, String, required: true
    argument :factory_id, ID, loads: Types::FactoryType, required: true

    type Types::PlaneType

    def resolve(plane:, manufacture:, factory:)
      plane if plane.update!(manufacture: manufacture, factory: factory)
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
