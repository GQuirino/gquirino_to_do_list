namespace :frontend do
  desc "Build React app and move to Rails public folder"
  task build: :environment do
    rails_root = Rails.root.to_s
    react_app_path = File.join(rails_root, "react-frontend")
    build_output_path = File.join(react_app_path, "build")
    rails_public_path = File.join(rails_root, "public")

    puts "Starting React build process..."

    # Step 1: Navigate to the React app directory and run the build command
    Dir.chdir(react_app_path) do
      puts "Installing npm dependencies..."
      system("npm install")

      puts "Building React app..."
      system("npm run build") or abort("React build failed!")
    end

    # Step 2: Remove any previous existing static file
    puts "Removing any previous existing static file..."
    system("rm -R #{rails_public_path}/static/*")

    # Step 2: Copy the build files to Rails' public directory
    puts "Copying build files to Rails public folder..."
    system("cp -R #{build_output_path}/* #{rails_public_path}/") or abort("Failed to copy build files!")

    puts "React app successfully built and moved to Rails public folder."
  end
end
