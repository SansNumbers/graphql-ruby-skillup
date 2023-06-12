# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateFactory, type: :request do
  let(:params) do
    {
      title: 'Factory Title',
      country: 'Factory Country'
    }
  end

  describe '.resolve' do
    it 'creates a factory' do
      expect do
        post '/graphql', params: { query: query, variables: { input: params } }
      end.to change { Factory.count }.by(1)
    end

    it 'returns a factory' do
      post '/graphql', params: { query: query, variables: { input: params } }
      json = JSON.parse(response.body)
      data = json['data']['createFactory']

      expect(data).to include(
        'id' => be_present,
        'title' => params[:title],
        'country' => params[:country]
      )
    end
  end

  def query
    <<~GQL
      mutation CreateFactoryMutation($input: CreateFactoryInput!) {
          createFactory(input: $input) {
              id
              title
              country
          }
      }
    GQL
  end
end
