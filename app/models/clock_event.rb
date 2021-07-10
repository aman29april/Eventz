class ClockEvent < ApplicationRecord
  validates :username, presence: true, allow_nil: false, length: { minimum: 3, maximum: 40 }
  validates :event_at, presence: true, allow_nil: false
  validates :event_type, allow_nil: false, inclusion: [true, false]
  validate :is_valid_type

  scope :ordered_by_event, -> { order(event_at: :desc) }

  scope :by_user, ->(username) { where(username: username) }

  before_create :set_event_at
  before_validation :set_event_at
  before_validation { username.downcase! }

  def event_text
    event_type == true ? 'IN' : 'OUT'
  end

  private

  def set_event_at
    self.event_at = DateTime.now if new_record?
  end

  def is_valid_type
    # records are ordered_by_event desc, so taking first
    last_event = ClockEvent.by_user(username).ordered_by_event.first
    message = ''
    if last_event.present?
      # last event don't meet current event
      message = "cannot be #{event_text} as your last  entry is also of #{event_text}"
      return if last_event.event_type != event_type
    else
      # No event till now, so 1st event should be log in
      message = 'cannot be clock out as it is your first entry'
      return if event_type == true
    end
    errors.add(:event_type, message)
  end
end
