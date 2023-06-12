# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreatePlane, type: :request do
  let(:factory) { create(:factory) }

  let(:params) do
    {
      manufacture: 'Plane Manufacture',
      factoryId: factory.id
    }
  end

  describe '.resolve' do
    it 'creates a plane' do
      expect do
        post '/graphql', params: { query: query, variables: { input: params } }
      end.to change { Plane.count }.by(1)
    end

    it 'returns a plane' do
      post '/graphql', params: { query: query, variables: { input: params } }
      json = JSON.parse(response.body)
      data = json['data']['createPlane']

      expect(data).to include(
        'id' => be_present,
        'manufacture' => params[:manufacture],
        'factoryId' => params[:factoryId]
      )
    end
  end

  def query
    <<~GQL
      mutation CreatePlaneMutation($input: CreatePlaneInput!) {
          createPlane(input: $input) {
              id
              manufacture
              factoryId
          }
      }
    GQL
  end
end
