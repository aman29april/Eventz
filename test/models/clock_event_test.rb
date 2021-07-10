require 'test_helper'

class ClockEventTest < ActiveSupport::TestCase
  test 'event_at should be valid datetime' do
    clock_event = ClockEvent.new({
                                   username: 'aman',
                                   event_type: true
                                 })

    assert clock_event.valid?, 'New event without event_at, set it automatically'
  end
  test 'username should be of length between 3 and 40' do
    clock_event = ClockEvent.new({
                                   username: 'a',
                                   event_type: true,
                                   event_at: DateTime.now
                                 })
    assert_not clock_event.valid?, 'Username length small'

    clock_event = ClockEvent.new({
                                   username: 'amankumaramankumaramankumaramankumaramankumaramankumaramankumar',
                                   event_type: true,
                                   event_at: DateTime.now
                                 })
    assert_not clock_event.valid?, 'Username longer than 40 characters'

    clock_event = ClockEvent.new({
                                   username: 'amank',
                                   event_type: true,
                                   event_at: DateTime.now
                                 })
    assert clock_event.valid?, 'Username length valid between 4 and 40'
  end

  test 'Event Type should be present with boolean value' do
    clock_event = ClockEvent.new({
                                   username: 'name',
                                   event_at: DateTime.now
                                 })

    assert_not clock_event.valid? 'Event type should have a value'

    clock_event = ClockEvent.new({
                                   username: 'name',
                                   event_type: false
                                 })
    assert clock_event.valid? 'Event type should have boolean value'
  end
end
