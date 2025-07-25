# frozen_string_literal: true

class AttendingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = find_event
    return unless can_attend?

    add_attendee
    redirect_to @event, notice: t('attendings.attending')
  end

  def destroy
    event = Event.find(params[:event_id])
    event.attendees.delete(current_user)
    redirect_to event, notice: t('attendings.not_attending')
  end

  private

  def find_event
    Event.find(params[:event_id])
  end

  def can_attend?
    return true unless @event.private?
    return true if @event.invitees.include?(current_user)

    redirect_to @event, alert: t('attendings.not_invited')
    false
  end

  def add_attendee
    @event.attendees << current_user unless @event.attendees.include?(current_user)
  end
end
