# frozen_string_literal: true

class CreateFactories < ActiveRecord::Migration[7.0]
  def change
    create_table :factories do |t|
      t.string :title
      t.string :country

      t.timestamps
    end
  end
end
