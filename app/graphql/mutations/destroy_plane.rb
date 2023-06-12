# frozen_string_literal: true

module Mutations
  class DestroyPlane < BaseMutation
    argument :id, ID, loads: Types::PlaneType, as: :plane, required: true

    type Types::PlaneType

    def resolve(plane:)
      plane.destroy!
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
