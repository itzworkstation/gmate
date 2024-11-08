class BrandSubCategory < ApplicationRecord
  belongs_to :brand
  belongs_to :sub_category
end
