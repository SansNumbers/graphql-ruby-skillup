# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::PlaneQueries, type: :request do
  describe 'success' do
    it 'returns a list of all planes' do
      post '/graphql', params: {
        query: query
      }

      json = JSON.parse(response.body)
      data = json['data']['planes']
      expect(data.length).to eq(Plane.count)

      first_plane = Plane.find(data.first['id'])
      expect(data.first['id'].to_i).to eq(first_plane.id)
    end
  end

  def query
    <<~GQL
      query PlanesQuery {
        planes {
          id
          manufacture
          factoryId
        }
      }
    GQL
  end
end
