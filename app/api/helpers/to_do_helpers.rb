module ToDoHelpers
  extend Grape::API::Helpers

  def find_item
    @todo = ToDo.find_by(id: params[:id])
    error!({ error: "Not Found" }, :not_found) unless @todo
  end
end
