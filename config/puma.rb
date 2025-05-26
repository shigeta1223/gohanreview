# config/puma.rb

max_threads_count = ENV.fetch("RAILS_MAX_THREADS", 5).to_i
min_threads_count = max_threads_count
threads min_threads_count, max_threads_count

#port ENV.fetch("PORT", 3000)
environment ENV.fetch("RAILS_ENV", "production")

app_root = File.expand_path("../..", __FILE__)
bind "unix://#{app_root}/tmp/sockets/puma.sock"

plugin :tmp_restart



