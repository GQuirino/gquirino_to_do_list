class ToDo < ApplicationRecord
  AVAILABLE_STATUS = {
    pending: "pending",
    completed: "completed"
  }.freeze

  enum :status, AVAILABLE_STATUS

  validates :status, presence: true, inclusion: { in: AVAILABLE_STATUS.values }
  validates :title, presence: true
  validates :description, presence: true

  default_scope { order(Arel.sql("CASE
                            WHEN status='pending' THEN 1
                            WHEN status='completed' THEN 2
                          END, title"))
  }
  scope :pending, -> { where(status: AVAILABLE_STATUS[:pending]) }
  scope :completed, -> { where(status: AVAILABLE_STATUS[:completed]) }
end
