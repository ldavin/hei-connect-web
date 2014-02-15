# == Schema Information
#
# Table name: features
#
#  id         :integer          not null, primary key
#  key        :string(255)
#  enabled    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Feature < ActiveRecord::Base
  attr_accessible :enabled, :key

  def self.enabled? feature_key
    feature = Feature.where(key: feature_key).first_or_create
    feature.enabled?
  end

  def self.enable! feature_key
    feature = Feature.where(key: feature_key).first_or_create
    feature.update_attribute :enabled, true unless feature.enabled?
  end

  def self.disable! feature_key
    feature = Feature.where(key: feature_key).first_or_create
    feature.update_attribute :enabled, false if feature.enabled?
  end

  def self.method_missing method, *args, &block
    name = method.to_s
    if name.end_with? '_enabled?'
      #key = name[0, name.length - '_enabled?'.length]
      key = name[0, name.length - '_enabled?'.length]
      Feature.enabled? key
    elsif name.start_with? 'enable_'
      key = name['enable_'.length, name.length]
      Feature.enable! key
    elsif name.start_with? 'disable_'
      key = name['disable_'.length, name.length]
      Feature.disable! key
    else
      super method, args, block
    end
  end

end
