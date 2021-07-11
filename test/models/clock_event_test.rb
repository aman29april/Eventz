require 'test_helper'

class ClockEventTest < ActiveSupport::TestCase
  setup do
    @clock_event = clock_events(:two)
  end

  test 'clock_in_at should be valid datetime' do
    clock_event = ClockEvent.new({
                                   username: 'aman',
                                   event_type: true
                                 })

    assert clock_event.valid?, 'New event without event_at, set it automatically'
  end

  test 'clock_out_at should be greater than clock in' do
    clock_event = clock_events(:invalid_out)
    assert_not clock_event.valid?, 'clock_out_at should be greater than clock in'
  end

  test 'clock_out_at should have max diff of 8 hours from clock in' do
    clock_event = clock_events(:max_diff_8)
    assert_not clock_event.valid?, 'clock out is more than 8 hours'
  end

  test 'username should be of length between 3 and 40' do
    clock_event = ClockEvent.new({
                                   username: 'a',
                                   event_type: true,
                                   clock_in_at: DateTime.now
                                 })
    assert_not clock_event.valid?, 'Username length small'

    clock_event = ClockEvent.new({
                                   username: 'amankumaramankumaramankumaramankumaramankumaramankumaramankumar',
                                   event_type: true,
                                   clock_in_at: DateTime.now
                                 })
    assert_not clock_event.valid?, 'Username longer than 40 characters'

    clock_event = ClockEvent.new({
                                   username: 'amank',
                                   event_type: true,
                                   clock_in_at: DateTime.now
                                 })
    assert clock_event.valid?, 'Username length valid between 4 and 40'
  end

  test 'Event Type should be present with boolean value' do
    clock_event = ClockEvent.new({
                                   username: 'name',
                                   clock_in_at: DateTime.now
                                 })

    assert_not clock_event.valid? 'Event type should have a value'

    clock_event = ClockEvent.new({
                                   username: 'name',
                                   event_type: false
                                 })
    assert_not clock_event.valid? 'First entry of event should be IN'
  end
end
