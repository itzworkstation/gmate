class IntegerValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.to_s =~ /\A[+-]?\d+\z/
      record.errors.add(attribute, :invalid, message: options[:message] || 'is not a valid integer')
    end
  end
end
