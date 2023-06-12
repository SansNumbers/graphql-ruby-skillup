# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::DestroyFactory, type: :request do
  let!(:factory) { create(:factory) }
  let(:params) do
    {
      id: factory.id.to_s
    }
  end

  describe '.resolve' do
    it 'destroys a factory' do
      expect do
        post '/graphql', params: { query: query, variables: { input: params } }
      end.to change { Factory.count }.by(-1)
    end

    it 'returns deleted factory' do
      post '/graphql', params: { query: query, variables: { input: params } }
      json = JSON.parse(response.body)
      data = json['data']['destroyFactory']
      expect(data).to include(
        'id' => params[:id],
        'title' => factory[:title],
        'country' => factory[:country]
      )
    end
  end

  def query
    <<~GQL
      mutation DestroyFactoryMutation($input: DestroyFactoryInput!) {
          destroyFactory(input: $input) {
              id
              title
              country
          }
      }
    GQL
  end
end
