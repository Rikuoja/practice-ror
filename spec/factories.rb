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
  end

  factory :brewery2, class: Brewery do
    name "Brewdog"
    year 1995
  end

  factory :beer do
    name "anonymous"
    brewery
    style "Lager"
  end

  factory :beer2, class: Beer do
    name "vehnyli"
    association :brewery, factory: :brewery2
    style "Weizen"
  end

end