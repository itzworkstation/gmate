# app/validators/no_tags_validator.rb
class NoTagsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.match?(/[<>&#@$%^=+*?-]/)
      record.errors.add(attribute, :invalid, message: options[:message] || 'contains tags or special characters')
    end
  end
end