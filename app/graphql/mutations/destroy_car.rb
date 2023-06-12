# frozen_string_literal: true

module Mutations
  class DestroyCar < BaseMutation
    argument :id, ID, loads: Types::CarType, as: :car, required: true

    type Types::CarType

    def resolve(car:)
      car.destroy!
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
