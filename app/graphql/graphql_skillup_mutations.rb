# frozen_string_literal: true

class GraphqlSkillupMutations < Types::BaseObject
  graphql_name 'Mutation'

  field :create_factory, mutation: Mutations::CreateFactory
  field :update_factory, mutation: Mutations::UpdateFactory
  field :destroy_factory, mutation: Mutations::DestroyFactory

  field :create_plane, mutation: Mutations::CreatePlane
  field :update_plane, mutation: Mutations::UpdatePlane
  field :destroy_plane, mutation: Mutations::DestroyPlane

  field :create_car, mutation: Mutations::CreateCar
  field :update_car, mutation: Mutations::UpdateCar
  field :destroy_car, mutation: Mutations::DestroyCar
end
