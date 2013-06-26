# encoding: utf-8

FactoryGirl.define do
  factory :exam do |f|
    f.name 'Exam très très dur'
    f.date { DateTime.now }
    f.kind ''
    f.weight 24.0
    f.average 0.0
    f.grades_count 0
  end
end