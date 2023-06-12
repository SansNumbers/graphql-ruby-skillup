# frozen_string_literal: true

FactoryBot.define do
  factory :plane do
    association :factory
    manufacture { 'Plane Manufacture' }
  end
end
