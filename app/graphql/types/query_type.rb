# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :todos, [ Types::ToDoType ], null: false do
      description "Retrieve a list of items"
      argument :status, String, required: false, description: "Filter by status (pending/completed)"
    end

    field :todo, Types::ToDoType, null: false do
      description "Retrieve a specific item by ID"
      argument :id, ID, required: true
    end

    def todos(status: nil)
      ::FilterService.new(ToDo.all, status).call
    end

    def todo(id:)
      ToDo.find(id)
    end
  end
end
