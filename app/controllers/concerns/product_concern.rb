# frozen_string_literal: true

module ProductConcern
  extend ActiveSupport::Concern
  def create_subcategory_product(name: nil, slug: nil, sub_category_id: nil)
    product = Product.find_or_initialize_by(name: name, sub_category_id: sub_category_id)
    product.persisted? || product.save ? product : nil
  end

  def create_subcategory_brand(name: nil, sub_category_id: nil)
    return name if name.nil?
    brand = Brand.find_or_create_by(name: name)
    sub_categories = brand.sub_categories
    if sub_categories.find_by(id: sub_category_id).nil?
      sub_categories.push(SubCategory.find(sub_category_id))
    end
    brand.id
  end
end
