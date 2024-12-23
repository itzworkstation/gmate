# frozen_string_literal: true

class AccountBlueprint < Blueprinter::Base
  identifier :name do |account, _option|
    account.name
  end

  fields :phone, :email

  view :basic do
    fields :id, :is_active
  end

  field :image_url do |product|
    Rails.application.routes.default_url_options[:host] + '/assets/accounts/profile.jpeg'
  end

  field :stores do |account, _options|
    StoreBlueprint.render_as_json(account.stores)
  end

  view :token_response do
    field :token do |account, _options|
      JwtService.encode({ account_id: account.id })
    end
  end
end
