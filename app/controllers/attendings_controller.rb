class AttendingsController < ApplicationController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])

    # Invite-only logic
    if event.private? && !event.invitees.include?(current_user)
      redirect_to event, alert: 'You are not invited to this private event.'
      return
    end

    unless event.attendees.include?(current_user)
      event.attendees << current_user
    end

    redirect_to event, notice: 'You are now attending this event.'
  end

  def destroy
    event = Event.find(params[:event_id])
    event.attendees.delete(current_user)
    redirect_to event, notice: 'You are no longer attending this event.'
  end
end
