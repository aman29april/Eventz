module ClockEventsHelper
  def event_type(type)
    type == true ? 'IN' : 'OUT'
  end

  def formatted_time(datetime)
    datetime.strftime('%l:%M %p - %B %e, %Y')
  end

  def display_username(name)
    truncate name, length: 10
  end

  def edit_title(id)
    "Edit Clock Event ##{id}"
  end
end
