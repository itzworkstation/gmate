# frozen_string_literal: true

class AccountBlueprint < Blueprinter::Base
  identifier :name do |account, _option|
    account.name
  end

  fields :phone, :email

  view :basic do
    fields :id, :is_active
  end

  field :image_url do |acc|
    acc.image_thumbnail || Rails.application.routes.default_url_options[:host] + '/assets/accounts/profile.jpeg'
  end

  field :stores do |account, _options|
    StoreBlueprint.render_as_json(account.stores)
  end

  view :admin do
    field :joining_date do |account, _options|
      account.created_at.strftime("%d-%b-%Y %I:%M %p")
    end
  end


  view :token_response do
    field :token do |account, _options|
      JwtService.encode({ account_id: account.id })
    end
  end
end
