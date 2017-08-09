# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Mod.count.zero?
  minecraft = Mod.create!(name: 'Minecraft', version: '1.12')
  default_icon = 'https://ftbwiki.org/images/2/29/Grid_Lucky_Block.png'

  wood = Item.create!(name: 'Wood', identifier: 'minecraft:wood', icon: 'https://ftbwiki.org/images/5/52/Grid_Oak_Wood.png', mod: minecraft)
  plank = Item.create!(name: 'Wood Plank', identifier: 'minecraft:wood_plank', icon: 'https://ftbwiki.org/images/d/d3/Grid_Oak_Wood_Plank.png', mod: minecraft)
  stick = Item.create!(name: 'Stick', identifier: 'minecraft:stick', icon: 'https://ftbwiki.org/images/e/e9/Grid_Stick.png', mod: minecraft)
  charcoal = Item.create!(name: 'Charcoal', identifier: 'minecraft:charcoal', icon: 'https://ftbwiki.org/images/5/58/Grid_Charcoal.png', mod: minecraft)
  torch = Item.create!(name: 'Torch', identifier: 'minecraft:torch', icon: 'https://ftbwiki.org/images/3/32/Grid_Torch.png', mod: minecraft)
  chest = Item.create!(name: 'Chest', identifier: 'minecraft:chest', icon: 'https://ftbwiki.org/images/c/c1/Grid_Chest.png', mod: minecraft)
  stairs = Item.create!(name: 'Stairs', identifier: 'minecraft:stairs', icon: default_icon, mod: minecraft)

  # Plank recipe
  recipe = Recipe.create!(item: plank, quantity: 4)
  recipe.ingredients << Ingredient.new(item: wood, quantity: 1)

  # Stick recipe
  recipe = Recipe.create!(item: stick, quantity: 4)
  recipe.ingredients << Ingredient.new(item: plank, quantity: 2)

  # Torch recipe
  recipe = Recipe.create!(item: torch, quantity: 4)
  recipe.ingredients << Ingredient.new(item: charcoal, quantity: 1)
  recipe.ingredients << Ingredient.new(item: stick, quantity: 1)

  # Chest recipe
  recipe = Recipe.create!(item: chest, quantity: 1)
  recipe.ingredients << Ingredient.new(item: plank, quantity: 8)

  # Stairs recipe
  recipe = Recipe.create!(item: stairs, quantity: 4)
  recipe.ingredients << Ingredient.new(item: plank, quantity: 6)
end
