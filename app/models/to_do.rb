class ToDo < ApplicationRecord
  enum status: { pending: "pending", complete: "complete" }
end
