# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  # Associations for attendees
  has_many :attendings, foreign_key: :attended_event_id
  has_many :attendees, through: :attendings, source: :attendee

  # Associations for invites
  has_many :invites, dependent: :destroy
  has_many :invitees, through: :invites, source: :invitee

  validates :name, presence: true
  validates :location, presence: true
  validates :date, presence: true
end
