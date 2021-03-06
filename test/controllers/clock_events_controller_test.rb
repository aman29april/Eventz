require 'test_helper'

class ClockEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @clock_event = clock_events(:one)
  end

  test 'should get index' do
    get clock_events_url
    assert_response :success
  end

  # On create, record count may or may not increase as we are using single record for IN and OUT
  # So create record from new user
  test 'should create clock_event' do
    event = clock_events(:unique_user)
    # delete existing records of the user
    ClockEvent.where(username: event.username).destroy_all
    assert_difference('ClockEvent.count') do
      post clock_events_url,
           params: { clock_event: { clock_in_at: event.clock_in_at, event_type: event.event_type,
                                    username: event.username } }
    end

    assert_redirected_to clock_events_url
  end

  test 'should get edit' do
    get edit_clock_event_url(@clock_event)
    assert_response :success
  end

  test 'should update clock_event' do
    patch clock_event_url(@clock_event),
          params: { clock_event: { clock_in_at: @clock_event.clock_in_at, event_type: @clock_event.event_type,
                                   username: @clock_event.username } }
    assert_redirected_to clock_events_url
  end

  test 'should destroy clock_event' do
    assert_difference('ClockEvent.count', -1) do
      delete clock_event_url(@clock_event)
    end

    assert_redirected_to clock_events_url
  end
end
