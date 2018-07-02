# frozen_string_literal: true

class CreateUser < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password, null: false
      t.timestamps null: false
    end
  end
end
