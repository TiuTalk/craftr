FactoryGirl.define do
  factory :item do
    mod
    name 'Torch'
    identifier { "#{mod.name.parameterize}:#{name.parameterize}" }
    icon 'https://ftbwiki.org/images/3/32/Grid_Torch.png'
  end
end
