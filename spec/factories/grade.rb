FactoryGirl.define do
  factory :grade do |f|
    f.mark 11.75
    f.unknown false
    f.update_number 5
  end
end