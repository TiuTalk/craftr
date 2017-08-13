class RecipeCalculator
  def initialize(item, quantity: 1)
    @item = item
    @quantity = quantity
  end

  def ingredients
    @item.ingredients.map do |ingredient|
      if ingredient.item.recipe.present?
        recipe = RecipeCalculator.new(ingredient.item, quantity: ingredient.quantity * crafting_operations)
        recipe.ingredients
      else
        ingredient.quantity *= crafting_operations
        ingredient
      end
    end.flatten
  end

  private

  def crafting_operations
    recipe = @item.recipe

    if recipe.present?
      (@quantity.to_f / recipe.quantity).ceil
    else
      @quantity
    end
  end
end
