# frozen_string_literal: true

# Simple in-memory rate limiter for login attempts
# Tracks failed login attempts by IP address
class RateLimiter
  @attempts = {}
  @mutex = Mutex.new

  class << self
    attr_reader :attempts, :mutex

    # Check if IP has exceeded maximum attempts in the time window
    def too_many_attempts?(ip, max_attempts: 5, window_minutes: 15)
      mutex.synchronize do
        cleanup_old_attempts(ip, window_minutes)
        current_attempts = attempts[ip] || []
        current_attempts.length >= max_attempts
      end
    end

    # Record a failed login attempt for this IP
    def record_attempt(ip)
      mutex.synchronize do
        attempts[ip] ||= []
        attempts[ip] << Time.now
      end
    end

    # Clear attempts for an IP (called on successful login)
    def clear_attempts(ip)
      mutex.synchronize do
        attempts.delete(ip)
      end
    end

    # Get remaining time until IP can try again
    def time_until_reset(ip, window_minutes: 15)
      mutex.synchronize do
        cleanup_old_attempts(ip, window_minutes)
        current_attempts = attempts[ip] || []
        return 0 if current_attempts.empty?

        oldest_attempt = current_attempts.first
        time_passed = Time.now - oldest_attempt
        remaining = (window_minutes * 60) - time_passed
        [remaining, 0].max.to_i
      end
    end

    # Get current attempt count for IP
    def attempt_count(ip, window_minutes: 15)
      mutex.synchronize do
        cleanup_old_attempts(ip, window_minutes)
        current_attempts = attempts[ip] || []
        current_attempts.length
      end
    end

    private

    # Remove attempts older than the time window
    def cleanup_old_attempts(ip, window_minutes)
      return unless attempts[ip]

      cutoff_time = Time.now - (window_minutes * 60)
      attempts[ip].select! { |time| time > cutoff_time }
      attempts.delete(ip) if attempts[ip].empty?
    end
  end
end