# class Business::CreatedUser < BaseService
#   include Request::SendRequest

#   attribute :email, Types::String
#   attribute :password, Types::String
#   attribute :encrypted_password, Types::String
#   attribute :role, Types::String.enum(*EnumLists::USER_ROLES)

#   def call
#     binding.pry
#   #   binding.pry
#   #   super
#   end

#   # private

#   # def on_failure(failure)
#   #   binding.pry
#   #   logger.error("#{self.class} >> #{failure}")
#   # end
# end