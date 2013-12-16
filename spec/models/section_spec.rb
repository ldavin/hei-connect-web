# == Schema Information
#
# Table name: sections
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Section do

  describe 'relations' do
    it { should have_many(:courses) }
    it { should have_many(:exams) }
    it { should have_many(:absences) }
  end

end
