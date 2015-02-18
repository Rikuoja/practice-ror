FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :user2, class: User do
    username "Riku"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :rating do
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :brewery do
    name "anonymous"
    year 1900
    active true
  end

  factory :brewery2, class: Brewery do
    name "Brewdog"
    year 1995
    active true
  end

  factory :beer do
    name "anonymous"
    brewery
    style
  end

  factory :beer2, class: Beer do
    name "vehnyli"
    association :brewery, factory: :brewery2
    association :style, factory: :style2
  end

  factory :style do
    name "Lager"
    description ""
  end

  factory :style2, class: Style do
    name "Weizen"
    description ""
  end
end