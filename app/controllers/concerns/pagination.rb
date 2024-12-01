# app/controllers/concerns/pagination.rb
module Pagination
  extend ActiveSupport::Concern

  included do
    # This method can be used by controllers to get paginated records
    helper_method :limit, :offset if respond_to?(:helper_method)
  end

  private

  def limit
    params[:limit].to_i > 0 ? params[:limit].to_i : 10 # Default limit is 10
  end

  def offset
    params[:offset].to_i > 0 ? params[:offset].to_i : 0 # Default offset is 0
  end
end
