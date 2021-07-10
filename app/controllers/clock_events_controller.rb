class ClockEventsController < ApplicationController
  before_action :set_clock_event, only: %i[ show edit update destroy ]

  def index
    @clock_events = ClockEvent.ordered_by_event.all
  end
  
  def new
    @clock_event = ClockEvent.new
  end

  def edit
  end

  # POST /clock_events or /clock_events.json
  def create
    @clock_event = ClockEvent.new(clock_event_params)

    respond_to do |format|
      if @clock_event.save
        format.html { redirect_to clock_events_path, notice: "Clock event was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @clock_event.update(clock_event_params)
        format.html { redirect_to clock_events_path, notice: "Clock event was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @clock_event.destroy
    respond_to do |format|
      format.html { redirect_to clock_events_url, notice: "Clock event was successfully destroyed." }
      format.json { head :no_content }
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
