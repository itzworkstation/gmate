module ProductConcern
  extend ActiveSupport::Concern
  def create_subcategory_product(name: nil, slug: nil, sub_category_id: nil)
    product = Product.find_or_initialize_by(name: name, sub_category_id: sub_category_id)
    (product.persisted? || product.save) ? product : nil
  end
end