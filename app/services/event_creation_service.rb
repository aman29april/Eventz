class EventCreationService
  def self.create_event(options)
    user_pending_event(options) || ClockEvent.new(options)
  end

  # if user has an incomplete event, update that and return
  def self.user_pending_event(options)
    user_last_event = ClockEvent.user_last_event(options[:username])
    return if user_last_event.blank? || user_last_event.complete?

    user_last_event.clock_out_at = DateTime.now if options[:event_type] == '0'
    user_last_event.event_type = options[:event_type]
    user_last_event
  end
end
