# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::DestroyPlane, type: :request do
  let!(:plane) { create(:plane) }
  let(:params) do
    {
      id: plane.id.to_s
    }
  end

  describe '.resolve' do
    it 'destroys a plane' do
      expect do
        post '/graphql', params: { query: query, variables: { input: params } }
      end.to change { Plane.count }.by(-1)
    end

    it 'returns deleted plane' do
      post '/graphql', params: { query: query, variables: { input: params } }
      json = JSON.parse(response.body)
      data = json['data']['destroyPlane']
      expect(data).to include(
        'id' => params[:id],
        'manufacture' => plane[:manufacture]
      )
    end
  end

  def query
    <<~GQL
      mutation DestroyPlaneMutation($input: DestroyPlaneInput!) {
          destroyPlane(input: $input) {
              id
              manufacture
          }
      }
    GQL
  end
end
