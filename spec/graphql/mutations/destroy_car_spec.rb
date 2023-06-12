# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::DestroyCar, type: :request do
  let!(:car) { create(:car) }
  let(:params) do
    {
      id: car.id.to_s
    }
  end

  describe '.resolve' do
    it 'destroys a car' do
      expect do
        post '/graphql', params: { query: query, variables: { input: params } }
      end.to change { Car.count }.by(-1)
    end

    it 'returns deleted car' do
      post '/graphql', params: { query: query, variables: { input: params } }
      json = JSON.parse(response.body)
      data = json['data']['destroyCar']
      expect(data).to include(
        'id' => params[:id],
        'manufacture' => car[:manufacture]
      )
    end
  end

  def query
    <<~GQL
      mutation DestroyCarMutation($input: DestroyCarInput!) {
          destroyCar(input: $input) {
              id
              manufacture
          }
      }
    GQL
  end
end
