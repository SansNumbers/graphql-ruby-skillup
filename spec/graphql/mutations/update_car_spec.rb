# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::UpdateCar, type: :request do
  let(:car) { create(:car) }

  let!(:params) do
    {
      id: car.id,
      manufacture: 'This is a new manufacture',
      factoryId: car.factory_id
    }
  end

  describe '.resolve' do
    it 'updates a car' do
      post '/graphql', params: { query: query, variables: { input: params } }
      json = JSON.parse(response.body)
      data = json['data']['updateCar']
      expect(car.reload).to have_attributes(
        'id' => params[:id],
        'manufacture' => params[:manufacture],
        'factory_id' => params[:factoryId]
      )
    end
  end

  def query
    <<~GQL
      mutation UpdateCarMutation($input: UpdateCarInput!) {
          updateCar(input: $input) {
              id
              manufacture
              factoryId
          }
      }
    GQL
  end
end
