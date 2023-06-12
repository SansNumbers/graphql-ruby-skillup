# frozen_string_literal: true

module Types
  class CarType < Types::BaseObject
    field :id, ID, null: false
    field :manufacture, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :factory_id, Integer, null: false

    def self.object_from_id(id, _ctx)
      ::Car.find(id)
    end
  end
end
