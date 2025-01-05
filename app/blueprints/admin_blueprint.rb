# frozen_string_literal: true

class AdminBlueprint < Blueprinter::Base
  identifier :id
  fields :email

  view :token_response do
    field :token do |admin, _options|
      JwtService.encode({ admin_id: admin.id })
    end
  end
end
