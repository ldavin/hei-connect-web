FactoryGirl.define do
  factory :course do |f|
    f.date { DateTime.new(DateTime.now.year, DateTime.now.month, DateTime.now.monday.day, 8, 0) }
    f.length 90
    f.kind 'Cours'
    f.ecampus_id 17475
    f.broken_name ''
  end
end