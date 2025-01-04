# frozen_string_literal: true

module Api
  module V1
    class Admin::AccountsController < BaseController
      api :POST, '/v1/accounts', 'Create an account'
      def login
        @admin = ::Admin.find_by(email: params[:email])
    
        if @admin && @admin.authenticate(params[:password])
          # Admin is authenticated, proceed with the session or token generation
          render_success(AdminBlueprint.render_as_json(@admin, view: :token_response), status: :ok, message: 'Logged in successfully')
        else
          render_error("Invalid email or password", status: :unauthorized)
        end
      end

      def index
        accounts = Account.all
        render_success(AccountBlueprint.render_as_json(accounts, view: :admin), status: :ok, message: 'Logged in successfully')
      end
    end
  end
end
