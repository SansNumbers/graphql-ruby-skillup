# frozen_string_literal: true

module Types
  class FactoryType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :country, String, null: false
    field :planes, [PlaneType], null: true
    field :cars, [CarType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :cars_count, Integer, null: true
    field :planes_count, Integer, null: true

    def cars_count
      object.cars.size
    end

    def planes_count
      object.planes.size
    end

    def self.object_from_id(id, _ctx)
      ::Factory.find(id)
    end
  end
end
