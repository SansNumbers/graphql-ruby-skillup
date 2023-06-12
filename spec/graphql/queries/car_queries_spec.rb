# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::CarQueries, type: :request do
  describe 'success' do
    it 'returns a list of all cars' do
      post '/graphql', params: {
        query: query
      }

      json = JSON.parse(response.body)
      data = json['data']['cars']
      expect(data.length).to eq(Car.count)

      first_car = Car.find(data.first['id'])
      expect(data.first['id'].to_i).to eq(first_car.id)
    end
  end

  def query
    <<~GQL
      query CarsQuery {
        cars {
          id
          manufacture
          factoryId
        }
      }
    GQL
  end
end
