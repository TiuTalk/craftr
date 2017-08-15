require 'rails_helper'

RSpec.describe RecipeCalculator, type: :service do
  let(:mod) { FactoryGirl.create(:mod) }

  let(:wood) { FactoryGirl.create(:item, name: 'Wood', mod: mod) }
  let(:plank) { FactoryGirl.create(:item, name: 'Plank', mod: mod) }
  let(:stairs) { FactoryGirl.create(:item, name: 'Stairs', mod: mod) }
  let(:stick) { FactoryGirl.create(:item, name: 'Stick', mod: mod) }
  let(:coal) { FactoryGirl.create(:item, name: 'Coal', mod: mod) }
  let(:torch) { FactoryGirl.create(:item, name: 'Torch', mod: mod) }

  describe '#ingredients' do
    context 'plank recipe' do
      before do
        recipe = Recipe.create!(item: plank, quantity: 4)
        recipe.ingredients << Ingredient.new(item: wood)
      end

      it 'return the correct ingredients' do
        ingredients = described_class.new(plank).ingredients

        expect(ingredients.count).to eq(1)

        ingredient = ingredients[0]
        expect(ingredient.item).to eq(wood)
        expect(ingredient.quantity).to eq(1)
      end

      it 'return the correct ingredients for 5 planks' do
        ingredients = described_class.new(plank, quantity: 5).ingredients

        expect(ingredients.count).to eq(1)

        ingredient = ingredients[0]
        expect(ingredient.item).to eq(wood)
        expect(ingredient.quantity).to eq(2)
      end

      it 'return the correct ingredients for 8 planks' do
        ingredients = described_class.new(plank, quantity: 8).ingredients

        expect(ingredients.count).to eq(1)

        ingredient = ingredients[0]
        expect(ingredient.item).to eq(wood)
        expect(ingredient.quantity).to eq(2)
      end
    end

    context 'stair recipe' do
      before do
        recipe = Recipe.create!(item: plank, quantity: 4)
        recipe.ingredients << Ingredient.new(item: wood)

        recipe = Recipe.create!(item: stairs, quantity: 4)
        recipe.ingredients << Ingredient.new(item: plank, quantity: 6)
      end

      it 'return the correct ingredients' do
        ingredients = described_class.new(stairs).ingredients

        expect(ingredients.count).to eq(1)

        ingredient = ingredients[0]
        expect(ingredient.item).to eq(wood)
        expect(ingredient.quantity).to eq(2)
      end

      it 'return the correct ingredients for 5 stairs' do
        ingredients = described_class.new(stairs, quantity: 5).ingredients

        expect(ingredients.count).to eq(1)

        ingredient = ingredients[0]
        expect(ingredient.item).to eq(wood)
        expect(ingredient.quantity).to eq(3)
      end

      it 'return the correct ingredients for 64 stairs' do
        ingredients = described_class.new(stairs, quantity: 64).ingredients

        expect(ingredients.count).to eq(1)

        ingredient = ingredients[0]
        expect(ingredient.item).to eq(wood)
        expect(ingredient.quantity).to eq(24)
      end
    end

    context 'torch recipe' do
      before do
        recipe = Recipe.create!(item: plank, quantity: 4)
        recipe.ingredients << Ingredient.new(item: wood)

        recipe = Recipe.create!(item: stick, quantity: 4)
        recipe.ingredients << Ingredient.new(item: plank, quantity: 2)

        recipe = Recipe.create!(item: torch, quantity: 4)
        recipe.ingredients << Ingredient.new(item: stick, quantity: 1)
        recipe.ingredients << Ingredient.new(item: coal, quantity: 1)
      end

      it 'return the correct ingredients' do
        ingredients = described_class.new(torch).ingredients

        expect(ingredients.count).to eq(2)

        ingredient = ingredients[0]
        expect(ingredient.item).to eq(wood)
        expect(ingredient.quantity).to eq(1)

        ingredient = ingredients[1]
        expect(ingredient.item).to eq(coal)
        expect(ingredient.quantity).to eq(1)
      end

      it 'return the correct ingredients for 2 torches' do
        ingredients = described_class.new(torch, quantity: 2).ingredients

        expect(ingredients.count).to eq(2)

        ingredient = ingredients[0]
        expect(ingredient.item).to eq(wood)
        expect(ingredient.quantity).to eq(1)

        ingredient = ingredients[1]
        expect(ingredient.item).to eq(coal)
        expect(ingredient.quantity).to eq(1)
      end

      it 'return the correct ingredients for 5 torches' do
        ingredients = described_class.new(torch, quantity: 5).ingredients

        expect(ingredients.count).to eq(2)

        ingredient = ingredients[0]
        expect(ingredient.item).to eq(wood)
        expect(ingredient.quantity).to eq(1)

        ingredient = ingredients[1]
        expect(ingredient.item).to eq(coal)
        expect(ingredient.quantity).to eq(2)
      end

      it 'return the correct ingredients for 64 torches' do
        ingredients = described_class.new(torch, quantity: 64).ingredients

        expect(ingredients.count).to eq(2)

        ingredient = ingredients[0]
        expect(ingredient.item).to eq(wood)
        expect(ingredient.quantity).to eq(2)

        ingredient = ingredients[1]
        expect(ingredient.item).to eq(coal)
        expect(ingredient.quantity).to eq(16)
      end
    end

    context 'custom recipe' do
      let(:item) { create(:item, name: 'Item', mod: mod) }
      let(:redstone) { create(:item, name: 'Redstone', mod: mod) }
      let(:redstone_torch) { create(:item, name: 'Redstone Torch', mod: mod) }

      before do
        recipe = Recipe.create!(item: plank, quantity: 4)
        recipe.ingredients << Ingredient.new(item: wood)

        recipe = Recipe.create!(item: stick, quantity: 4)
        recipe.ingredients << Ingredient.new(item: plank, quantity: 2)

        recipe = Recipe.create!(item: redstone_torch, quantity: 1)
        recipe.ingredients << Ingredient.new(item: redstone, quantity: 1)
        recipe.ingredients << Ingredient.new(item: stick, quantity: 1)

        recipe = Recipe.create!(item: item, quantity: 1)
        recipe.ingredients << Ingredient.new(item: plank, quantity: 2)
        recipe.ingredients << Ingredient.new(item: stick, quantity: 1)
        recipe.ingredients << Ingredient.new(item: redstone_torch, quantity: 1)
      end

      it 'return the correct ingredients' do
        ingredients = described_class.new(item).ingredients

        expect(ingredients.count).to eq(2)

        ingredient = ingredients[0]
        expect(ingredient.item).to eq(wood)
        expect(ingredient.quantity).to eq(1)

        ingredient = ingredients[1]
        expect(ingredient.item).to eq(redstone)
        expect(ingredient.quantity).to eq(1)
      end
    end
  end
end
