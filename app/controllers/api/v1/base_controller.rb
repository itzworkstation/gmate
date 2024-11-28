# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      include Respondable
      rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
      rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
      rescue_from Apipie::ParamMissing, Apipie::ParamInvalid, Apipie::ParamMultipleMissing,
                  with: :handle_parameter_missing

      private

      def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
          @decoded = JwtService.decode(header)
          @current_account = Account.find(@decoded[:account_id])
        rescue JWT::DecodeError
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
      end

      def handle_error(exception)
        # Log the exception
        Rails.logger.error(exception.message)
        Rails.logger.error(exception.backtrace.join("\n"))

        # Return an appropriate error response
        render json: { error: 'Internal Server Error' }, status: :internal_server_error
      end

      def handle_not_found(exception)
        model_name = exception.model.constantize.name
        render json: { error: "#{model_name} not found" }, status: :not_found
      end

      def handle_parameter_missing(exception)
        render json: { error: exception.message }, status: :unprocessable_entity
      end
    end
  end
end
