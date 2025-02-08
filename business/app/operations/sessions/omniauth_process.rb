module Sessions
  class OmniauthProcess < Micro::Case
    flow Omniauth,
         Users::InitiateActivation
  end
end
