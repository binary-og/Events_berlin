# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Invitations
  has_many :invitations, foreign_key: :inviter_id, dependent: :destroy, inverse_of: :inviter
  has_many :sent_invitations, foreign_key: :inviter_id, class_name: 'Invitation', dependent: :destroy,
                              inverse_of: :inviter
  has_many :received_invitations, foreign_key: :invitee_id, class_name: 'Invitation', dependent: :destroy,
                                  inverse_of: :invitee

  # Events the user is attending
  has_many :attendings, foreign_key: :attendee_id, inverse_of: :attendee, dependent: :destroy
  has_many :attended_events, through: :attendings, source: :attended_event

  # Events the user is attending
  has_many :attendances, dependent: :destroy

  # associates user_id with creator_id in events table and allows event.creator method
  has_many :events, foreign_key: :creator_id, class_name: 'Event', dependent: :destroy, inverse_of: :creator

  # Events the user has created
  has_many :created_events, foreign_key: 'creator_id', class_name: 'Event', dependent: :destroy, inverse_of: :creator
end
