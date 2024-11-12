class ToDo < ApplicationRecord
  AVAILABLE_STATUS = {
    pending: "pending",
    completed: "completed"
  }.freeze

  enum :status, AVAILABLE_STATUS

  validates :status, presence: true, inclusion: { in: AVAILABLE_STATUS.values }
  validates :title, presence: true
  validates :description, presence: true

  scope :pending, -> { where(status: AVAILABLE_STATUS[:pending]) }
  scope :completed, -> { where(status: AVAILABLE_STATUS[:completed]) }
end
