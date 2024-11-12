module ToDoApp
  class Base < Grape::API
    format :json
    prefix :api

    mount ToDoApp::V1::ToDos

    # Swagger API Documentation
    add_swagger_documentation(
      info: {
        title: "GQuirino To-Do API",
        description: "Kadince Assignment - API tp manage To-Do list"
      },
      api_version: "v1",
      hide_format: true,
      hide_documentation_path: true,
      mount_path: "/swagger_doc",
      produces: [ "application/json" ]
    )
  end
end
