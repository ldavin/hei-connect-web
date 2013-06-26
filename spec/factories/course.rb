FactoryGirl.define do
  factory :course do |f|
    f.date { DateTime.now }
    f.length 90
    f.kind 'Cours'
    f.ecampus_id 17475
    f.broken_name ''
  end
end