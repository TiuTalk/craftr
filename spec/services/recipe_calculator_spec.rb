require 'rails_helper'

RSpec.describe RecipeCalculator, type: :service do
  let(:mod) { FactoryGirl.create(:mod) }

  let(:wood) { FactoryGirl.create(:item, name: 'Wood', mod: mod) }
  let(:plank) { FactoryGirl.create(:item, name: 'Plank', mod: mod) }
  let(:stairs) { FactoryGirl.create(:item, name: 'Stairs', mod: mod) }

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
    end
  end
end
