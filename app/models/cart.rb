require 'pry'
class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def total
    cost = 0
    self.items.each do |item|
      cost += item.price
    end
    cost
  end

  def add_item(item_id)
    item = Item.find_by_id(item_id)
    if !self.line_items.include?(item)
      self.line_items.build(item_id: item.id)

    else
      self.line_items.find_by_item_id(item.id).increment! :quantity
      binding.pry
    end

  end

end
