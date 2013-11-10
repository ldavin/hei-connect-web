FactoryGirl.define do
  factory :update do |f|
    f.object Update::OBJECT_USER.to_s
    f.state Update::STATE_UNKNOWN.to_s
    f.rev 0
  end
end