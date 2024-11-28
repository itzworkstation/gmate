# frozen_string_literal: true

class StoreProduct < ApplicationRecord
  enum state: { available: 0, consuming: 1, consumed: 2 }
  enum measurement_unit: { pouch: 0, grm: 1, kg: 2, ltr: 3, ml: 4, pack: 5 }
  belongs_to :product
  belongs_to :store
  belongs_to :brand, required: false
  after_save :update_product_count
  after_destroy :update_product_count

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
end
