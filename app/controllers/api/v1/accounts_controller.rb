# frozen_string_literal: true

module Api
  module V1
    class AccountsController < BaseController
      before_action :authorize_request, only: [:update]
      def_param_group :account do
        param :account, Hash, desc: 'account parameters', required: true do
          param :name, String, desc: 'Account name', required: false
          param :email, String, desc: 'Account email', required: false
          param :phone, String, desc: 'Phone link to account', required: true
        end
      end

      api :GET, '/v1/accounts', 'Get a list of accounts'
      def index
        accounts = Account.all
        render_success(AccountBlueprint.render_as_json(accounts, view: :basic), status: :ok, message: 'Success')
      end

      api :POST, '/v1/accounts', 'Create an account'
      param_group :account
      def create
        account = Account.find_or_initialize_by(phone: account_params[:phone])
        account.name = account.phone if account.name.nil?
        account.send_otp=true
        if account.save
          render_success({}, status: :ok, message: 'otp has been sent')
        else
          render_error(account.errors.full_messages.join(','), status: :unprocessable_entity)
        end
      end

      api :PUT, '/v1/accounts', 'Update an account'
      def update
        if @current_account.update(update_params)
          render_success({}, status: :ok, message: 'Profile updated')
        else
          render_error(@current_account.errors.full_messages.join(','), status: :unprocessable_entity)
        end
      end
      
      api :POST, '/v1/accounts/verify_otp', 'Verify an account'
      param :phone, String, desc: 'Phone link to account', required: true
      param :otp, String, desc: 'Authentication otp', required: true
      def verify_otp
        account = Account.find_by(phone: params[:phone])
        return render_error('Phone is invalid', status: :unprocessable_entity) if account.nil?
        if account.validate_otp?(params[:otp])
          render_success(AccountBlueprint.render_as_json(account, view: :token_response), status: :ok, message: 'Success')
        else
          render_error('OTP is invalid or expired', status: :unprocessable_entity)
        end
      end



      private

      def account_params
        params.require(:account).permit(:id, :name, :email, :phone)
      end
      def update_params
        params.require(:account).permit(:id, :name, :email, :language)
      end
    end
  end
end
