# frozen_string_literal: true

class Factory < ApplicationRecord
  has_many :cars, dependent: :delete_all
  has_many :planes, dependent: :delete_all
end
