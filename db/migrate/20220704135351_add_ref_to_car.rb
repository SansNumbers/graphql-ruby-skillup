# frozen_string_literal: true

class AddRefToCar < ActiveRecord::Migration[7.0]
  def change
    add_reference :cars, :factory, null: false, foreign_key: true
  end
end
