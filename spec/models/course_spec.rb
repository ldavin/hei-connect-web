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
  let(:section)  { create :section, name: 'Chimie organique' }
  let(:rooms)    { [ create(:room, name: 'AC602') ] }
  let(:teachers) { [ create(:teacher, name: 'Jean Mi') ] }
  let(:course)   { create :course, kind: 'Cours', section: section, rooms: rooms, teachers: teachers }

  describe '#to_ical_event' do
    let(:expected_event) {
      event = RiCal.Event
      event.dtstart = course.date
      event.dtend = course.date + course.length.minutes
      event.summary = 'Cours - Chimie organique'
      event.description = "Cours de Chimie organique\r\nPar Jean Mi."
      event.location = 'AC602'
      event.created = course.created_at.to_datetime
      event.last_modified = course.updated_at.to_datetime

      event
    }

    subject { course.to_ical_event }

    it { should eq expected_event }
  end

  describe '#to_fullcalendar_event' do
    let(:expected_hash) { { id: course.id, title: 'Cours - Chimie organique, AC602', start: course.date,
                            end: course.date + course.length.minutes, allDay: false } }
    subject { course.to_fullcalendar_event }

    it { should eq expected_hash }
  end

  describe '#name' do
    subject { course.name }

    context 'when there is a broken name' do
      let(:course) { build :course, broken_name: 'cassé' }
      it { should eq 'cassé' }
    end

    context 'when there is NOT a broken name' do
      it { should eq 'Cours - Chimie organique' }
    end
  end

  describe '#description' do
    subject { course.description }

    context 'when there is a broken name' do
      let(:course) { build :course, broken_name: 'cassé' }
      it { should eq Course::UNKNOWN_DESCRIPTION }
    end

    context 'when there are teachers' do
      let(:teachers) { [ build(:teacher, name: 'Bibi'), build(:teacher, name: 'Bobo') ] }
      it { should eq "Cours de Chimie organique\r\nPar Bibi, Bobo." }
    end

    context 'when there are NO teachers' do
      let(:course) { build :course, section: section }
      it { should eq 'Cours de Chimie organique' }
    end
  end

  describe '#place' do
    subject { course.place }

    context 'when in a single room' do
      it { should eq 'AC602' }
    end

    context 'when in several rooms' do
      let(:rooms) { [ build(:room, name: 'RR131'), build(:room, name: 'RR132') ] }
      it { should eq 'RR131, RR132' }
    end

    context 'when in NO rooms' do
      let(:rooms) { [] }
      it { should eq Course::UNKNOWN_PLACE }
    end
  end
end
