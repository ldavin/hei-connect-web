require 'spec_helper'

describe CourseUser do

  describe 'relations' do
    it { should belong_to(:course) }
    it { should belong_to(:user) }
  end

end