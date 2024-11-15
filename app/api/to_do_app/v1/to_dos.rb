module ToDoApp
  module V1
    class ToDos < Grape::API
      version "v1", using: :path
      format :json
      prefix :api

      helpers ::Helpers::ToDoHelpers

      resource :todos do
        before { find_item if params[:id] }

        # POST api/v1/todos
        desc "Create a new to-do", {
          success: { code: :created, message: "Creates a new to-do item" }
        }
        params do
          requires :title, type: String, desc: "Title of the to-do"
          requires :description, type: String, desc: "Description of the to-do"
          optional :status, type: String, values: %w[pending complete], default: "pending", desc: "Status of the to-do"
        end
        post do
          todo = ToDo.create!(declared(params))
          serialize(todo)
        end

        # PUT api/v1/todos/:id
        desc "Update a to-do", {
          success: { code: 200, message: "Updates a to-do item" }
        }
        params do
          requires :id, type: Integer, desc: "to-do id"
          optional :title, type: String, desc: "Title of the to-do"
          optional :description, type: String, desc: "Description of the to-do"
          optional :status, type: String, values: %w[pending complete], desc: "Status of the to-do"
        end
        put ":id" do
          @todo.update!(declared(params, include_missing: false))
          serialize(@todo)
        end

        # DELETE api/v1/todos/:id
        desc "Delete a to-do", {
          success: { code: :no_content, message: "Deletes a to-do item" }
        }
        params do
          requires :id, type: Integer, desc: "To-do id"
        end
        delete ":id" do
          @todo.destroy
        end

        # PATCH api/v1/todos/:id/complete
        desc "Complete a to-do", {
          success: { code: :ok, message: "Marks a to-do item as completed" }
        }
        params do
          requires :id, type: Integer, desc: "To-do id"
        end
        patch ":id/complete" do
          @todo.completed!
          serialize(@todo)
        end
      end
    end
  end
end
