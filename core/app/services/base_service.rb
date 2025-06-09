class BaseService < Dry::Struct
  transform_keys(&:to_sym)

  attr_accessor :logger

  def self.call(params)
    @logger = Rails.logger

    self.new(params).call
  end
end
