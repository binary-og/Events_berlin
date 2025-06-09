# frozen_string_literal: true

class CreateAttendings < ActiveRecord::Migration[7.0]
  def change
    create_table :attendings, &:timestamps
  end
end
