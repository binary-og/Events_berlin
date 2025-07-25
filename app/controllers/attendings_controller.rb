# frozen_string_literal: true

class AttendingsController < ApplicationController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])

    if invite_only_blocked?(event)
      redirect_to event, alert: t('alerts.not_invited')
      return
    end

    event.attendees << current_user unless event.attendees.include?(current_user)

    redirect_to event, notice: t('alerts.attending')
  end

  private

  def invite_only_blocked?(event)
    event.private? && event.invitees.exclude?(current_user)
  end

  def destroy
    event = Event.find(params[:event_id])
    event.attendees.delete(current_user)
    redirect_to event, notice: t('alerts.not_attending')
  end
end
