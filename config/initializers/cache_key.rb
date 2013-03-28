module ActiveRecord
  class Base
    def self.cache_key
      if self.column_names.include?("updated_at")
        "#{scoped.maximum(:updated_at).try(:to_i)}-#{scoped.count}"
      elsif self.column_names.include?("created_at")
        "#{scoped.maximum(:created_at).try(:to_i)}-#{scoped.count}"
      else
        "#{scoped.count}"
      end
    end
  end
end