class UsersController < ApplicationController
  def user_events
    @clock_events = ClockEvent.by_user(params[:username]).ordered_by_event
    @has_pending_event = true if @clock_events.any? && @clock_events.first.incomplete?
  end

  def log_user_event
    @clock_event = EventCreationService.create_event(params.permit(:username, :event_type))
    if @clock_event.save
      redirect_back(fallback_location: clock_events_path, success: 'Clock event was successfully created.')
    else
      redirect_back(fallback_location: clock_events_path, error: @clock_event.errors.full_messages.to_sentence)
    end
  end
end
