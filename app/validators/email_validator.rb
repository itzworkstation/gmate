# frozen_string_literal: true

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.present? && value !~ URI::MailTo::EMAIL_REGEXP

    record.errors.add(attribute, :invalid,
                      message: options[:message] || 'is not a valid email address')
  end
end
