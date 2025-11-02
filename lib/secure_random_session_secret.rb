# frozen_string_literal: true

class SecureRandomSessionSecret
  def self.generate
    Logger.new($stdout).warn(message)
    SecureRandom.hex(64)
  end

  def self.message
    <<~MSG
      Generating a new random session secret. You should set the SESSION_SECRET environment variable in production!
    MSG
  end
end
