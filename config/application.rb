require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Gohanreview
  class Application < Rails::Application
    config.load_defaults 7.2

    # ActiveStorage で mini_magick を使用
    config.active_storage.variant_processor = :mini_magick

    # lib配下の自動読み込みで、不要ディレクトリを無視
    config.autoload_lib(ignore: %w[assets tasks])
  end
end
