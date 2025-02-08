module Users
  class CreationProcess < Micro::Case
    flow CreatedUser,
         InitiateActivation
  end
end
