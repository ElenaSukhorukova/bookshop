module EventsMounter
  extend ActiveSupport::Concern

  # include EventsMounter

  included do
    # def mount_event(type, payload)
    #   puts '----------------------------'
    #   pp type
    #   pp payload
    #   puts '----------------------------'
    #   event_listener = Events::EventListener.new
    #   event_register = Events::EventRegister.new

    #   event_register.subscribe(event_listener)
    #   event_register.publish(type, payload)
    # end
  end


  # def send_message_to_business
  #   mount_event('users.created', self.as_json)
  # end
end
