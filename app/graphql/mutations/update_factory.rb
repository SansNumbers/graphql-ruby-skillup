# frozen_string_literal: true

module Mutations
  class UpdateFactory < BaseMutation
    argument :id, ID, required: true, loads: ::Types::FactoryType, as: :factory
    argument :title, String, required: true
    argument :country, String, required: true

    type Types::FactoryType

    def resolve(factory:, title:, country:)
      factory if factory.update!(title: title, country: country)
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
