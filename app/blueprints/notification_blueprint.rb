# frozen_string_literal: true

class NotificationBlueprint < Blueprinter::Base
  identifier :id

  field :created_at do |msg|
    msg.created_at.strftime("%d-%b-%Y %I:%M %p")
  end

  fields :message, :read
end
