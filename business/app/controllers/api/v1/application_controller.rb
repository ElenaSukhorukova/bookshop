class Api::V1::ApplicationController < ApplicationController
  include Authorization

  private

  def permit_params(owner = nil)
    permitted_params =
      if owner.present?
        params.permit!.to_h[owner]
      else
        params.permit!.to_h
      end

    permitted_params || {}
  end
end
