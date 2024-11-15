# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_todo, Types::ToDoType, null: false do
      argument :title, String, required: true
      argument :description, String, required: true
      argument :status, String, required: false
    end

    field :update_todo, Types::ToDoType, null: false do
      argument :id, ID, required: true
      argument :title, String, required: false
      argument :description, String, required: false
      argument :status, String, required: false
    end

    field :delete_todo, Boolean, null: false do
      argument :id, ID, required: true
    end

    def create_todo(title:, description:, status: "pending")
      ToDo.create(title: title, description: description, status: status)
    end

    def update_todo(id:, title: nil, description: nil, status: nil)
      todo = ToDo.find(id)
      todo.update(title: title, description: description, status: status)
      todo
    end

    def delete_todo(id:)
      todo = ToDo.find(id)
      todo.destroy
      true
    end
  end
end
