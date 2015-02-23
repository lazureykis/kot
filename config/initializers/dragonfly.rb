require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick
    # convert_command: "/opt/local/bin/convert",   # defaults to "convert"
    # identify_command: "/opt/local/bin/identify"  # defaults to "identify"

  secret '10b25f8c1be2d44214a1b0ca3900f48f66daf60ff0d86882c6f4f24f55a82090'

  url_format '/media/:job/:name'

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
    server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
