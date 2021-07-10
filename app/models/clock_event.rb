class ClockEvent < ApplicationRecord
  validates :username, presence: true, allow_nil: false, length: { minimum: 3, maximum: 40 }
  validates :event_at, presence: true, allow_nil: false
  validates :event_type, allow_nil: false, inclusion: [true, false]

  scope :ordered_by_event, -> { order(event_at: :desc) }

  before_create :set_event_at
  before_validation :set_event_at

  private

  def set_event_at
    self.event_at = DateTime.now if new_record?
  end
end
