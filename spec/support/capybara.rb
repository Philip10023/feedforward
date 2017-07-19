def wait_for_ajax
  return unless respond_to?(:evaluate_script)
  wait_until { finished_all_ajax_requests? }
end

def finished_all_ajax_requests?
  evaluate_script("!window.jQuery") || evaluate_script("jQuery.active").zero?
end

def wait_until(max_execution_time_in_seconds = Capybara.default_wait_time)
  Timeout.timeout(max_execution_time_in_seconds) do
    loop do
      if yield
        return true
      else
        sleep(0.05)
        next
      end
    end
  end
end

class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || ConnectionPool::Wrapper.new(size: 1) { retrieve_connection }
  end
end

RSpec.configure do |config|
  config.before :all do
    # Forces all threads to share the same connection. This works on
    # Capybara because it starts the web server in a thread.
    ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
  end

  config.before :each, js: true do
    # Need to wait for active connections because of shared_connection hack
    # Fixes errors like
    # PG::UnableToSend: another command is already in progress
    # undefined method `fields' for nil:NilClass
    # PG::UnableToSend: socket not open
    wait_for_ajax
  end
end
