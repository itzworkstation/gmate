# app/controllers/concerns/respondable.rb
module Respondable
  extend ActiveSupport::Concern

  included do
    # Any code here will be executed when the module is included in the controller
  end

  # Define response methods
  def render_success(data, status: :ok, message: 'Success')
    render json: {
      success: true,
      message: message,
      data: data
    }, status: status
  end

  def render_error(message, status: :unprocessable_entity)
    render json: {
      success: false,
      message: message,
      data: nil
    }, status: status
  end
end
