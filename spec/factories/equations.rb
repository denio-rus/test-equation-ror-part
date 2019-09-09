FactoryBot.define do
  factory :equation do
    a { rand(1..30) }
    b { rand(1..30) }
    c { rand(1..30) }
  end
end

