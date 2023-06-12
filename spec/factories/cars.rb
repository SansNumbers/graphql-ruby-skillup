# frozen_string_literal: true

FactoryBot.define do
  factory :car do
    association :factory
    manufacture { 'Car Manufacture' }
  end
end
