# frozen_string_literal: true

module Api
  module V1
    class AccountsController < BaseController
      def_param_group :account do
        param :account, Hash, desc: 'account parameters', required: true do
          param :name, String, desc: 'Account name', required: true
          param :email, String, desc: 'Account email', required: false
          param :phone, String, desc: 'Phone link to account', required: true
        end
      end

      api :GET, '/v1/accounts', 'Get a list of accounts'
      def index
        accounts = Account.all
        render json: AccountBlueprint.render(accounts, view: :basic)
      end

      api :POST, '/v1/accounts', 'Create an account'
      param_group :account
      def create
        account = Account.find_or_initialize_by(phone: account_params[:phone])
        account.name = account.phone if account.name.nil?
        account.send_otp=true
        if account.save
          render json: {message: 'otp has been sent'}
        else
          render json: { error: account.errors.full_messages.join(',') }
        end
      end

      api :POST, '/v1/accounts/verify_otp', 'Verify an account'
      param :phone, String, desc: 'Phone link to account', required: true
      param :otp, String, desc: 'Authentication otp', required: true
      def verify_otp
        account = Account.find_by(phone: params[:phone])
        return render json: { error: 'Phone is invalid' } if account.nil?
        if account.validate_otp?(params[:otp])
          render json: AccountBlueprint.render(account, view: :token_response)
        else
          render json: { error: 'OTP is invalid or expired' }
        end
      end



      private

      def account_params
        params.require(:account).permit(:id, :name, :email, :phone)
      end
    end
  end
end
