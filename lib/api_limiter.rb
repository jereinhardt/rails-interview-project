require 'rack/throttle'

class APILimiter < Rack::Throttle::Limiter
  def allowed?(request)
    if request.path.starts_with? "/api/"
      daily_limiter.allowed?(request) || fallback_limiter.allowed?(request)
    else
      true
    end
  end

  private

  def daily_limiter
    @daily_limiter ||= Rack::Throttle::Daily.new(app, max: 100)
  end

  def fallback_limiter
    @fallback_limiter ||= Rack::Throttle::Interval.new(app, min: 10.0)
  end
end
