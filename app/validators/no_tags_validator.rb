# frozen_string_literal: true

# app/validators/no_tags_validator.rb
class NoTagsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.match?(/[<>&#@$%^=+*?-]/)

    record.errors.add(attribute, :invalid,
                      message: options[:message] || 'contains tags or special characters')
  end
end
