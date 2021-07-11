class EventCreationService
  def self.create_event(params)
    user_last_event = ClockEvent.user_last_event(params[:username])
    if user_last_event.present? && user_last_event.incomplete?
      clock_event = user_last_event
      clock_event.clock_out_at = DateTime.now if params[:event_type] == '0'
      clock_event.event_type = params[:event_type]
    else
      clock_event = ClockEvent.new(params)
    end
    clock_event
  end
end
