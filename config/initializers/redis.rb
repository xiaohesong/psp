require "redis"
require "redis-namespace"
require "redis/objects"


redis_config = YAML.load_file("#{Rails.root}/config/redis.yml")[Rails.env]

$redis = Redis::Namespace.new("#{Rails.env}_psp", redis: Redis.new(host: redis_config['host'], port: redis_config['port']))
Redis::Objects.redis = $redis
