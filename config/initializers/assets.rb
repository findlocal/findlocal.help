Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Add Yarn node_modules folder to the asset load path
Rails.application.config.assets.paths << Rails.root.join("node_modules")

# Precompile additional assets
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
