# Be sure to restart your server when you modify this file.

Rails.application.config.assets.version = "1.0"

# Exclude Tailwind source files from being served directly by Propshaft.
# They are build inputs only — the compiled output goes to app/assets/builds/.
Rails.application.config.assets.excluded_paths << Rails.root.join("app/assets/stylesheets")
