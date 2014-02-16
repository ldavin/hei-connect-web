# == Schema Information
#
# Table name: sections
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string(255)
#  updated_at :datetime         not null
#
# Indexes
#
#  index_sections_on_name  (name)
#

require 'spec_helper'

describe Section do

  describe 'relations' do
    it { should have_many(:courses) }
    it { should have_many(:exams) }
    it { should have_many(:absences) }
  end

end
