# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::UpdateFactory, type: :request do
  let(:factory) { create(:factory) }

  let!(:params) do
    {
      id: factory.id,
      title: 'New Title',
      country: 'New Country'
    }
  end

  describe '.resolve' do
    it 'updates a factory' do
      post '/graphql', params: { query: query, variables: { input: params } }
      json = JSON.parse(response.body)
      data = json['data']['updateFactory']
      expect(factory.reload).to have_attributes(
        'id' => params[:id],
        'title' => params[:title],
        'country' => params[:country]
      )
    end
  end

  def query
    <<~GQL
      mutation UpdateFactoryMutation($input: UpdateFactoryInput!) {
          updateFactory(input: $input) {
              id
              title
              country
          }
      }
    GQL
  end
end
