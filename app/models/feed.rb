# frozen_string_literal: true

class Feed
  include Redisable

  def initialize(type, id, electorate = nil)
    @type = type
    @id   = id
    @electorate = electorate
  end

  def get(limit, max_id = nil, since_id = nil, min_id = nil)
    limit    = limit.to_i
    max_id   = max_id.to_i if max_id.present?
    since_id = since_id.to_i if since_id.present?
    min_id   = min_id.to_i if min_id.present?

    from_redis(limit, max_id, since_id, min_id)
  end

  protected

  def from_redis(limit, max_id, since_id, min_id)
    max_id = '+inf' if max_id.blank?
    if min_id.blank?
      since_id   = '-inf' if since_id.blank?
      unhydrated = redis.zrevrangebyscore(key, "(#{max_id}", "(#{since_id}", limit: [0, limit], with_scores: true).map(&:first).map(&:to_i)
    else
      unhydrated = redis.zrangebyscore(key, "(#{min_id}", "(#{max_id}", limit: [0, limit], with_scores: true).map(&:first).map(&:to_i)
    end

    @electorate ? Status.part_of_electorate(@electorate).where(id: unhydrated).cache_ids : Status.where(id: unhydrated).cache_ids
  end

  def key
    FeedManager.instance.key(@type, @id)
  end
end
