# encoding: utf-8
# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  date        :datetime
#  length      :integer
#  kind        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  ecampus_id  :integer
#  section_id  :integer
#  group_id    :integer
#  broken_name :string(255)
#

require 'spec_helper'

describe Course do

  let(:course) { FactoryGirl.create :course, kind: 'Cours' }

  it 'should generate an ical event' do
    course.section = FactoryGirl.build :section, name: 'Chimie organique'
    course.rooms = [ FactoryGirl.build(:room, name: 'AC602') ]
    course.teachers = [ FactoryGirl.build(:teacher, name: 'Jean Mi') ]

    expected_event = RiCal.Event
    expected_event.dtstart = course.date
    expected_event.dtend = course.date + course.length.minutes
    expected_event.summary = 'Cours - Chimie organique'
    expected_event.description = "Cours de Chimie organique\r\nPar Jean Mi."
    expected_event.location = 'AC602'
    expected_event.created = course.created_at.to_datetime
    expected_event.last_modified = course.updated_at.to_datetime

    course.to_ical_event.should == expected_event
  end

  it 'should generate a full_calendar event' do
    course.section = FactoryGirl.build :section, name: 'Electrotechnique'
    course.rooms = [ FactoryGirl.build(:room, name: 'B216') ]

    expected_hash = {
                         id: course.id,
                         title: 'Cours - Electrotechnique, B216',
                         start: course.date,
                         end: course.date + course.length.minutes,
                         allDay: false
                     }

    course.to_fullcalendar_event.should == expected_hash
  end

  describe 'should know its name' do
    context 'when the data is incomplete' do
      it 'should return the broken name' do
        course.broken_name = 'Ecampus evil event'

        course.name.should == 'Ecampus evil event'
      end
    end

    context 'when the data is complete' do
      it 'should concatenate the kind, section and teachers name' do
        course.section = FactoryGirl.build :section, name: 'Automatique séquentielle'

        course.name.should == 'Cours - Automatique séquentielle'
      end
    end
  end


  describe 'should be able to describe itself' do
    context 'when the data is incomplete' do
      it 'should return unknown' do
        course.broken_name = 'Ecampus evil event'

        course.description.should == Course::UNKNOWN_DESCRIPTION
      end
    end

    context 'when the data is complete' do
      context 'when there are teachers' do
        it 'should return everything concatenated' do
          course.section = FactoryGirl.build :section, name: 'Mathématiques'
          course.teachers = [ FactoryGirl.build(:teacher, name: 'Bibi'), FactoryGirl.build(:teacher, name: 'Bobo') ]

          course.description.should == "Cours de Mathématiques\r\nPar Bibi, Bobo."
        end
      end

      context 'when there are no teachers' do
        it 'should concatenate the kind and section name' do
          course.section = FactoryGirl.build :section, name: 'Mathématiques'

          course.description.should == 'Cours de Mathématiques'
        end
      end
    end
  end

  describe 'should know where it takes place' do
    context 'when in a single room' do
      it 'should return the room name' do
        course.rooms = [ FactoryGirl.build(:room, name: 'C416') ]

        course.place.should == 'C416'
      end
    end

    context 'when in several rooms' do
      it 'should concatenate the rooms names' do
        course.rooms = [ FactoryGirl.build(:room, name: 'RR131'), FactoryGirl.build(:room, name: 'RR132') ]

        course.place.should == 'RR131, RR132'
      end
    end

    context 'when in no rooms' do
      it 'should return unknown' do
        course.rooms = []

        course.place.should == Course::UNKNOWN_PLACE
      end
    end
  end

end
