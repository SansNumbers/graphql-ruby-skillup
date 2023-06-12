# frozen_string_literal: true

module Mutations
  class CreateCar < BaseMutation
    argument :manufacture, String, required: true
    argument :factory_id, ID, loads: Types::FactoryType, required: true

    type Types::CarType

    def resolve(manufacture:, factory:)
      car = Car.create!(
        manufacture: manufacture, factory: factory
      )
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
