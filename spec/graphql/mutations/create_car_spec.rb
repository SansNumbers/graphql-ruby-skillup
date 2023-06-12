# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateCar, type: :request do
  let(:factory) { create(:factory) }

  let(:params) do
    {
      manufacture: 'Car Manufacture',
      factoryId: factory.id
    }
  end

  describe '.resolve' do
    it 'creates a car' do
      expect do
        post '/graphql', params: { query: query, variables: { input: params } }
      end.to change { Car.count }.by(1)
    end

    it 'returns a car' do
      post '/graphql', params: { query: query, variables: { input: params } }
      json = JSON.parse(response.body)
      data = json['data']['createCar']

      expect(data).to include(
        'id' => be_present,
        'manufacture' => params[:manufacture],
        'factoryId' => params[:factoryId]
      )
    end
  end

  def query
    <<~GQL
      mutation CreateCarMutation($input: CreateCarInput!) {
          createCar(input: $input) {
              id
              manufacture
              factoryId
          }
      }
    GQL
  end
end
