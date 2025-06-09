# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Invites
  has_many :invites, foreign_key: :inviter_id, dependent: :destroy
  has_many :sent_invites, foreign_key: :inviter_id, class_name: 'Invite'
  has_many :received_invites, foreign_key: :invitee_id, class_name: 'Invite'

  # Events the user is attending
  has_many :attendings, foreign_key: :attendee_id, dependent: :destroy
  has_many :attended_events, through: :attendings, dependent: :destroy

  # Events the user is attending
  has_many :attendings, foreign_key: :attendee_id
  has_many :attended_events, through: :attendings, source: :attended_event
  has_many :attendances

  # associates user_id with creator_id in events table and allows event.creator method
  has_many :events, foreign_key: :creator_id, class_name: 'Event', dependent: :destroy

  # Events the user has created
  has_many :created_events, foreign_key: 'creator_id', class_name: 'Event'
end
