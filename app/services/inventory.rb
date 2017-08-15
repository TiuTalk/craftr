class Inventory
  def initialize(items = [])
    @items = items
  end

  def has_item?(item, quantity: 1)
    @items.any? do |inventory_item|
      inventory_item.item.identifier == item.identifier && inventory_item.quantity >= quantity
    end
  end

  def add_item(item, quantity: 1)
    if has_item?(item)
      @items = @items.map do |inventory_item|
        inventory_item.quantity += quantity if inventory_item.item.identifier == item.identifier
        inventory_item
      end
    else
      @items << Ingredient.new(item: item, quantity: quantity)
    end
  end

  def remove_item(item, quantity: 1)
    @items = @items.map do |inventory_item|
      inventory_item.quantity -= quantity if inventory_item.item.identifier == item.identifier
      inventory_item
    end.reject do |item|
      item.quantity <= 0
    end
  end

  def to_s
    @items.map(&:to_s).join(', ')
  end
end
