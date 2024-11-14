class ToDoSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :status
end
