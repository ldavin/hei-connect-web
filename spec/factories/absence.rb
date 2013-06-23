# spec/factories/contacts.rb
require 'faker'

FactoryGirl.define do
  factory :absence do |f|
    f.date { DateTime.now }
    f.length { 90 }
    f.excused { [true, false].sample }
    f.justification { Faker::Lorem.words.join ' ' }
    f.update_number { Random.rand(10) }
  end
end