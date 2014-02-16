# == Schema Information
#
# Table name: features
#
#  created_at    :datetime         not null
#  enabled       :boolean          default(FALSE)
#  error_message :string(255)
#  id            :integer          not null, primary key
#  key           :string(255)
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :feature do
    key "MyString"
    enabled false
    error_message "MyString"
  end
end
