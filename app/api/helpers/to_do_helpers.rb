module Helpers
  module ToDoHelpers
    extend Grape::API::Helpers

    def find_item
      @todo = ToDo.find_by(id: params[:id])
      error!({ error: "Not Found" }, :not_found) unless @todo
    end

    def serialize(item)
      ActiveModelSerializers::SerializableResource.new(item).as_json
    end
  end
end
