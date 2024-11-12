module ToDoApp
  module V1
    class ToDos < Grape::API
      version "v1", using: :path
      format :json
      prefix :api

      helpers ::ToDoHelpers

      resource :todos do
        before { find_item if params[:id] }

        # GET api/v1/todos
        desc "Get all to-dos list", {
          success: { code: :ok, message: "Returns all to-do items" },
          is_array: true
        }
        get do
          ToDo.all
        end

        # GET api/v1/todos/:id
        desc "Get a to-do", {
          success: { code: :ok, message: "Returns a to-do item" }
        }
        params do
          requires :id, type: Integer, desc: "To-do id"
        end
        get ":id" do
          @todo
        end
      end
    end
  end
end
