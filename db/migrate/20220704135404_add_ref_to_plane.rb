# frozen_string_literal: true

class AddRefToPlane < ActiveRecord::Migration[7.0]
  def change
    add_reference :planes, :factory, null: false, foreign_key: true
  end
end
