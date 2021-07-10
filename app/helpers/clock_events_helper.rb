module ClockEventsHelper

  def event_type(type)
    type == true ? "IN" : "OUT"
  end

  def event_type_class(type)
    type == true ? "left" : "right"
  end

  def formatted_time(datetime)
    datetime.strftime('%B %e, %Y - %l:%M %p')
  end

  def display_username(name)
    truncate name, length: 10
  end
end
