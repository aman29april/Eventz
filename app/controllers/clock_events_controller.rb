class ClockEventsController < ApplicationController
  before_action :set_clock_event, only: %i[edit update destroy]

  def index
    @clock_event = ClockEvent.new
    @clock_events = ClockEvent.ordered_by_event.all
  end

  def edit; end

  def create
    @clock_event = ClockEvent.new(clock_event_params)

    respond_to do |format|
      if @clock_event.save
        format.html { redirect_to clock_events_path, success: 'Clock event was successfully created.' }
      else
        format.html { redirect_to clock_events_path, error: @clock_event.errors.full_messages.to_sentence }
        # @clock_events = ClockEvent.ordered_by_event.all
        # format.html { render :index, locals:  {clock_event: @clock_event}}
      end
    end
  end

  def update
    respond_to do |format|
      if @clock_event.update(clock_event_params)
        format.html { redirect_to clock_events_path, success: 'Clock event was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @clock_event.destroy
    respond_to do |format|
      format.html { redirect_to clock_events_url, success: 'Clock event was successfully destroyed.' }
    end
  end

  private

  def set_clock_event
    @clock_event = ClockEvent.find(params[:id])
  end

  def clock_event_params
    params.require(:clock_event).permit(:username, :event_type, :event_at)
  end
end
