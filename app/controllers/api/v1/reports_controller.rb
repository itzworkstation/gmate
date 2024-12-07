# frozen_string_literal: true

module Api
  module V1
    class ReportsController < BaseController
      before_action :authorize_request

      api :GET, '/v1/reports', 'Get a list of accounts'
      # param :from_date, String, desc: 'From date filter', required: false
      # param :to_date, String, desc: 'To date filter', required: false
      # param :send_to_email, String, desc: 'Send email or not', required: false
      def index
        file_path = Rails.root.join('data', 'report.json')
        render_success(JSON.parse(File.read(file_path)), status: :ok, message: 'Success')
      end
    end
  end
end

