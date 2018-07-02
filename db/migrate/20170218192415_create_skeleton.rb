# frozen_string_literal: true

class CreateSkeleton < ActiveRecord::Migration[5.0]
  def change
    create_table :skeletons do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
