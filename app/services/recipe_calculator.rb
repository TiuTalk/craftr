class RecipeCalculator
  attr_reader :item, :inventory

  def initialize(item, quantity: 1, inventory: Inventory.new)
    @item = item
    @quantity = quantity
    @inventory = inventory
    @ingredients = []
  end

  def process
    if has_item?(item, @quantity)
      use_item(item, @quantity)
    elsif has_recipe?
      process_recipe
    else
      add_ingredient(Ingredient.new(item: item, quantity: @quantity))
      add_item(item, @quantity)
    end
  end

  def ingredients
    process

    @ingredients
  end

  def crafted_items
    if has_recipe?
      crafting_operations * item.recipe.quantity
    else
      crafting_operations
    end
  end

  private

  def process_recipe
    item.ingredients.includes(item: { recipe: :ingredients }).each do |ingredient|
      ingredient.quantity *= crafting_operations

      recipe = RecipeCalculator.new(ingredient.item, quantity: ingredient.quantity, inventory: @inventory)
      recipe.ingredients.each { |ingredient| add_ingredient(ingredient) }
      add_item(recipe.item, recipe.crafted_items)
    end
  end

  def has_recipe?
    @has_recipe ||= item.recipe.present?
  end

  def has_item?(item, quantity = 1)
    @inventory.has_item?(item, quantity: quantity)
  end

  def add_item(item, quantity = 1)
    @inventory.add_item(item, quantity: quantity)
  end

  def use_item(item, quantity = 1)
    @inventory.remove_item(item, quantity: quantity)
  end

  def add_ingredient(ingredient)
    @ingredients << ingredient
  end

  def crafting_operations
    recipe = item.recipe

    if recipe.present?
      (@quantity.to_f / recipe.quantity).ceil
    else
      @quantity
    end
  end
end
