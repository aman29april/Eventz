require_relative '../services/event_creation_service'
class ClockEventsController < ApplicationController
  before_action :set_clock_event, only: %i[edit update destroy]

  def index
    @clock_event = ClockEvent.new
    @clock_events = ClockEvent.ordered_by_event.all
  end

  def edit; end

  def create
    @clock_event = EventCreationService.create_event(clock_create_params)
    if @clock_event.save
      redirect_to clock_events_path, success: 'Clock event was successfully created.'
    else
      redirect_to clock_events_path, error: @clock_event.errors.full_messages.to_sentence
    end
  end

  def update
    if @clock_event.update(clock_update_params)
      redirect_to clock_events_path, success: 'Clock event was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @clock_event.destroy
    redirect_back(fallback_location: clock_events_path, success: 'Clock event was successfully destroyed.')
  end

  private

  def set_clock_event
    @clock_event = ClockEvent.find(params[:id])
  end

  def clock_create_params
    params.require(:clock_event)
          .permit(:username, :event_type, :clock_in_at)
  end

  def clock_update_params
    params.require(:clock_event)
          .permit(:username, :event_type, :clock_in_at, :clock_out_at)
          .merge(is_update: true)
  end
end
