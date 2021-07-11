class ClockEvent < ApplicationRecord
  validates :username, presence: true, allow_nil: false, length: { minimum: 3, maximum: 40 }
  validates :clock_in_at, presence: true, allow_nil: false
  validates :event_type, allow_nil: false, inclusion: [true, false]

  # on update of record, we can skip validating record type
  validate :is_valid_type, unless: :is_update
  validate :is_valid_clock_out_at
  attr_accessor :is_update

  scope :ordered_by_event, -> { order(clock_in_at: :desc) }
  scope :by_user, ->(username) { where(username: username) }
  scope :clock_in_on, ->(date) { where(clock_in_at: date.all_day) }

  before_create :set_clock_in_at
  before_validation :set_clock_in_at
  before_validation { username.downcase! }
  after_validation :set_hours_clocked

  def self.user_last_event(user)
    ClockEvent.by_user(user).last
  end

  def event_text
    event_type == true ? 'IN' : 'OUT'
  end

  def complete?
    clock_out_at.present?
  end

  def incomplete?
    !complete?
  end

  def self.hours_clocked_on_day(user, date = DateTime.now)
    ClockEvent.by_user(user).clock_in_on(date).sum(:hours_clocked)
  end

  private

  def set_clock_in_at
    self.clock_in_at = DateTime.now if new_record?
  end

  def set_hours_clocked
    return if incomplete?

    self.hours_clocked = DateUtil.hours_between(clock_in_at, clock_out_at)
  end

  # @todo We need refactor. Once we have authentication, todo can be simplified as only current user can create its events
  # If there is no event, current event should be clock IN
  # If this event is of type IN, new event should be of type OUT
  def is_valid_type
    return if complete?
    return if new_record? && event_type == true
    return if !new_record? && incomplete? && event_type == false

    message = if new_record? && event_type == false
                'cannot be clock out as there is no open clock in entry'
              else
                "cannot be #{event_text} as your last clock is also #{event_text}"
              end
    errors.add(:event_type, message)
  end

  # clock out should be greater than clock in
  # Max difference of 8 hours between clock out and in
  def is_valid_clock_out_at
    return if incomplete?

    errors.add(:clock_out_at, 'should be greater than check in') if clock_out_at < clock_in_at
    if DateUtil.minutes_between(clock_out_at, clock_in_at) > (8 * 60)
      errors.add(:clock_out_at, 'should have difference of maximum 8 hours from clock in')
    end
  end
end
