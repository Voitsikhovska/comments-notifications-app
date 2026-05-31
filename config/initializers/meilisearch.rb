MeiliSearch::Rails.configuration = {
  meilisearch_url: ENV.fetch("MEILISEARCH_URL", "http://localhost:7700"),
  meilisearch_api_key: Rails.env.production? ? ENV.fetch("MEILISEARCH_API_KEY") : ENV["MEILISEARCH_API_KEY"],
  raise_on_failure: Rails.env.production?
}.compact
