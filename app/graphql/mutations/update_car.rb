# frozen_string_literal: true

module Mutations
  class UpdateCar < BaseMutation
    argument :id, ID, loads: Types::CarType, as: :car, required: true
    argument :manufacture, String, required: true
    argument :factory_id, ID, loads: Types::FactoryType, required: true

    type Types::CarType

    def resolve(car:, manufacture:, factory:)
      car if car.update!(manufacture: manufacture, factory: factory)
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
