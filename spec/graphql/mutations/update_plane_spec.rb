# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::UpdatePlane, type: :request do
  let(:plane) { create(:plane) }

  let!(:params) do
    {
      id: plane.id,
      manufacture: 'This is a new manufacture',
      factoryId: plane.factory_id
    }
  end

  describe '.resolve' do
    it 'updates a plane' do
      post '/graphql', params: { query: query, variables: { input: params } }
      json = JSON.parse(response.body)
      data = json['data']['updatePlane']
      expect(plane.reload).to have_attributes(
        'id' => params[:id],
        'manufacture' => params[:manufacture],
        'factory_id' => params[:factoryId]
      )
    end
  end

  def query
    <<~GQL
      mutation UpdatePlaneMutation($input: UpdatePlaneInput!) {
          updatePlane(input: $input) {
              id
              manufacture
              factoryId
          }
      }
    GQL
  end
end
