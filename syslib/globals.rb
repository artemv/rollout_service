module Globals
  extend self

  def environment
    $env = ENV['RACK_ENV'] || 'development'
  end

  def redis
    $redis = Redis.new(url: ENV['REDIS_URL'])
  end

  def rollout
    $rollout = Rollout.new($redis, use_sets: true)
  end

  def authentication
    config =  YAML.load(File.read('./config/authentication.yml'))[$env]
    $google_oauth_allowed_domain = config[:google_oauth_allowed_domain]
  end

  def setup
    environment
    redis
    rollout
    authentication
  end
end


