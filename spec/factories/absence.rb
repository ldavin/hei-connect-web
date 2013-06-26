FactoryGirl.define do
  factory :absence do |f|
    f.date { DateTime.now }
    f.length 90
    f.excused false
    f.justification 'Avait mal aux pieds'
    f.update_number 3
  end
end