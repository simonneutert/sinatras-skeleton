

require 'active_support/core_ext/time'
require 'active_support/core_ext/date'
require 'active_support/core_ext/numeric/time'
# Time.zone = "Berlin"
#
# check out all available timezones:
# http://api.rubyonrails.org/classes/ActiveSupport/TimeZone.html

class Time
  def to_local
    in_time_zone('Berlin')
  end
end
