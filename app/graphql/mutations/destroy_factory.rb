# frozen_string_literal: true

module Mutations
  class DestroyFactory < BaseMutation
    argument :id, ID, loads: Types::FactoryType, as: :factory, required: true

    type Types::FactoryType

    def resolve(factory:)
      factory.destroy!
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
