# frozen_string_literal: true

class StoreProduct < ApplicationRecord
  enum state: { available: 0, consuming: 1, consumed: 2 }
  enum measurement_unit: { pouch: 0, grm: 1, kg: 2, ltr: 3, ml: 4, pack: 5 }
  belongs_to :product
  belongs_to :store
  belongs_to :brand, required: false
  after_save :update_product_count
  after_destroy :update_product_count
  after_commit :notify_store_on_update, on: :update
  scope :by_store, ->(store_id) { where(store_id: store_id) }
  scope :by_category, ->(category_id) { joins(product: [sub_category: :category]).where(categories: { id: category_id }) }
  scope :by_product_name, ->(q) { joins(:product).where("products.name ILIKE ?", "%#{q}%") }

  scope :filtered, ->(store_id, category_id, q) {
    by_store(store_id)
      .then { |query| category_id.present? ? query.by_category(category_id) : query }
      .then { |query| q.present? ? query.by_product_name(q) : query }
  }


  def next_state
    states = StoreProduct.states.keys
    current_index = states.index(state)
    next_index = (current_index + 1) % states.length
    next_index == 0 ? '' : states[next_index]
  end

  def previous_state
    states = StoreProduct.states.keys
    current_index = states.index(state)
    prev_index = (current_index - 1) % states.length
    states[prev_index]
  end

  # Get all next statuses (starting from the current status)
  def all_next_states
    states = StoreProduct.states.keys
    current_index = states.index(state)
    next_states = states[(current_index)..-1] # Next statuses from current
    next_states
  end



  private
  def update_product_count
    store.update_products_count
  end

  def notify_store_on_update
    product_name = product.name
    fields = saved_changes.delete_if {|key, v| key == 'updated_at'}.keys
    value = fields.size > 1 ? 'values' : 'value'
    message = "You have updated '#{fields.join(', ')}' #{value} of #{product_name}"
    if saved_change_to_state?
      message = (state == 'consuming') ? "Your have started consuming '#{product_name}' " : "Your have consumed '#{product_name}' "
    end
    Notification.create(store_id: self.store_id, message: message)
  end
end
