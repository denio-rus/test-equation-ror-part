FactoryBot.define do
  factory :equation do
    a_param { rand(1..30) }
    b_param { rand(1..30) }
    c_param { rand(1..30) }
    type { :quadratic }

    trait :linear do
      type { :linear }
    end
  end
end

