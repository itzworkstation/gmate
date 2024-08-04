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

      api :GET, '/accounts', 'Get a list of accounts'
      def index
        accounts = Account.all
        render json: AccountBlueprint.render(accounts, view: :basic)
      end

      api :POST, '/accounts', 'Create an account'
      param_group :account
      def create
        account = Account.new(account_params)
        if account.save
          render json: AccountBlueprint.render(account, view: :token_response)
        else
          render json: { error: account.errors.full_messages.join(',') }
        end
      end

      private

      def account_params
        params.require(:account).permit(:id, :name, :email, :phone)
      end
    end
  end
end
