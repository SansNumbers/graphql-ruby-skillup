# frozen_string_literal: true

class CreatePlanes < ActiveRecord::Migration[7.0]
  def change
    create_table :planes do |t|
      t.string :manufacture

      t.timestamps
    end
  end
end
