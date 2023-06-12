# frozen_string_literal: true

class GraphqlSkillupQueries < Types::BaseObject
  graphql_name 'Query'

  field :factories, resolver: ::Queries::FactoryQueries
  field :cars, resolver: ::Queries::CarQueries
  field :planes, resolver: ::Queries::PlaneQueries
end
