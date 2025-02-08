module Sessions
  class SessionProcess < Micro::Case
    flow NewSession,
         Authentication
  end
end
