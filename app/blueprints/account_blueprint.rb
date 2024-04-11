class AccountBlueprint < Blueprinter::Base
  identifier :name do |account, _option|
    account.name
  end

  
  fields :phone, :email

  view :basic do
    fields :id, :is_active
  end

  view :token_response do
    field :token do |account, options|
      JwtService.encode({id: account.id})
    end
    field :otp do |account, options|
      account.otp_code(time: Time.now + 1.minute)
    end
  end
end