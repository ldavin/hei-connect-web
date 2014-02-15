require 'spec_helper'

feature 'User checks its grades' do

  before :each do
    Feature.enable_user_login
    Feature.where(key: 'update_grades', enabled: true, error_message: 'MAJ désactivée!').first_or_create
    sign_out
    user.user_ok!
  end

  given(:id)       { 'h01234' }
  given(:password) { 'password' }
  given!(:user)    { create :user, ecampus_id: id, password: password}
  given!(:user_session) { create :user_session, user: user }

  given(:section) { create :section }
  given(:exam)    { create :exam, section: section }
  given!(:grade)  { create :grade, exam: exam }

  context 'when user HAS grades' do
    before :each do
      user_session.grades << grade
    end

    scenario 'on dashboard home', js: true do
      sign_in_with id, password

      expect(page).to have_content "Moyenne #{user_session.title}"
      expect(page).to have_selector '#average-chart svg'
    end

    scenario 'on grades page', js: true do
      sign_in_with id, password
      visit dashboard_grades_path ecampus_id: user.ecampus_id, year: user_session.year, try: user_session.try

      expect(page).to have_content "Moyenne #{user_session.title}"
      expect(page).to have_selector '#average-chart svg'
      expect(page).to have_content "Notes #{user_session.title}"
      expect(page).to have_content section.name
      expect(page).to have_content exam.name
      expect(page).to have_content grade.mark
    end

  end

  context 'when user does NOT have grades' do

    scenario 'on dashboard home', js: true do
      sign_in_with id, password

      expect(page).to have_content "Moyenne #{user_session.title}"
      expect(page).to have_content 'Aucune note pour l\'instant.'
      expect(page).not_to have_selector '#average-chart svg'
    end

    scenario 'on grades page', js: true do
      sign_in_with id, password
      visit dashboard_grades_path ecampus_id: user.ecampus_id, year: user_session.year, try: user_session.try

      expect(page).to have_content "Moyenne #{user_session.title}"
      expect(page).to have_content 'Aucune note pour l\'instant.'
      expect(page).not_to have_selector '#average-chart svg'
      expect(page).to have_content "Notes #{user_session.title}"
      expect(page).not_to have_content 'Matière'
    end
  end

  context 'check feature flags' do
    scenario 'when updates are disabled', js: true do
      Feature.disable_update_grades
      sign_in_with id, password
      visit dashboard_grades_path ecampus_id: user.ecampus_id, year: user_session.year, try: user_session.try

      expect(page).to have_content Feature.update_grades_error_message
    end

    scenario 'when updates are enabled', js: true do
      Feature.enable_update_grades
      sign_in_with id, password
      visit dashboard_grades_path ecampus_id: user.ecampus_id, year: user_session.year, try: user_session.try

      expect(page).not_to have_content Feature.update_grades_error_message
    end
  end
end