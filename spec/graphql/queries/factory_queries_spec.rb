# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::FactoryQueries, type: :request do
  let(:factory) { create(:factory) }

  describe 'success' do
    it 'returns a single factory' do
      post '/graphql', params: {
        query: query
      }
      json = JSON.parse(response.body)
      data = json['data']['factory']
      expect(data['id'].to_i).to eq(factory.id)
    end
  end

  def query
    <<~GQL
      query FactoryQuery {
          factory(id: #{factory.id}){
              id
              title
              country
              planesCount
              carsCount
              cars {
                  id,
                  manufacture
              }
              planes {
                  id,
                  manufacture
              }
          }
      }
    GQL
  end
end
