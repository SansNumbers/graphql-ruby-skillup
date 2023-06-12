# frozen_string_literal: true

module Types
  class PlaneType < Types::BaseObject
    field :id, ID, null: false
    field :manufacture, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :factory_id, Integer, null: false

    def self.object_from_id(id, _ctx)
      ::Plane.find(id)
    end
  end
end
