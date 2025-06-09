# frozen_string_literal: true

class CreateInvites < ActiveRecord::Migration[7.0]
  def change
    create_table :invites, &:timestamps
  end
end
