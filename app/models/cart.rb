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
    line_item = self.line_items.find_by(item_id: item_id)
    # binding.pry
    if line_item
      line_item.quantity += 1
      line_item.save
    else
      line_item = self.line_items.build(item_id: item_id)
    end
    # binding.pry
    line_item
  end

  def checkout
    self.line_items.each do |line_item|
      item = Item.find(line_item.item_id)
      item.inventory = item.inventory - line_item.quantity
      item.save
    end
    # binding.pry
    user.update(current_cart: nil)
    self.update(status: "submitted")
  end

end
