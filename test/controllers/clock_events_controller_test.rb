require 'test_helper'

class ClockEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @clock_event = clock_events(:one)
  end

  test 'should get index' do
    get clock_events_url
    assert_response :success
  end

  test 'should get new' do
    get new_clock_event_url
    assert_response :success
  end

  test 'should create clock_event' do
    assert_difference('ClockEvent.count') do
      post clock_events_url,
           params: { clock_event: { event_at: @clock_event.event_at, event_type: @clock_event.event_type,
                                    username: @clock_event.username } }
    end

    assert_redirected_to clock_events_url
  end

  test 'should get edit' do
    get edit_clock_event_url(@clock_event)
    assert_response :success
  end

  test 'should update clock_event' do
    patch clock_event_url(@clock_event),
          params: { clock_event: { event_at: @clock_event.event_at, event_type: @clock_event.event_type,
                                   username: @clock_event.username } }
    assert_redirected_to clock_events_url
  end

  # test 'should destroy clock_event' do
  #   assert_difference('ClockEvent.count', -1) do
  #     delete clock_events_url
  #   end
  #
  #   assert_redirected_to clock_events_url
  # end
end
