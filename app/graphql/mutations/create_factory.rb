# frozen_string_literal: true

module Mutations
  class CreateFactory < BaseMutation
    argument :title, String, required: true
    argument :country, String, required: true

    type Types::FactoryType

    def resolve(title:, country:)
      factory = Factory.create!(
        title: title, country: country
      )
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
