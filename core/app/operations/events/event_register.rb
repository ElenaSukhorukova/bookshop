module Events
  class EventRegister
    include Dry::Events::Publisher[:basic_publisher]

    # register_event('users.created')
  end
end
