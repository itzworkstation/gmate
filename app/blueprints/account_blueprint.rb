# frozen_string_literal: true

class AccountBlueprint < Blueprinter::Base
  identifier :name do |account, _option|
    account.name
  end

  fields :phone, :email

  view :basic do
    fields :id, :is_active
  end

  view :token_response do
    field :token do |account, _options|
      JwtService.encode({ account_id: account.id })
    end
  end
end
