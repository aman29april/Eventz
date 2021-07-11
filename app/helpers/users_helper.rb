module UsersHelper
  # current user hours for day
  def hours_for_day
    hrs = ClockEvent.hours_clocked_on_day(params[:username])
    hrs.present? ? hrs.round(2) : 0
  end
end
