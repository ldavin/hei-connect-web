require 'spec_helper'

feature 'User checks its absences' do

  before :each do
    Feature.enable_user_login
    Feature.where(key: 'update_absences', enabled: true, error_message: 'MAJ désactivée!').first_or_create
    sign_out
    user.user_ok!
  end

  given(:id) { 'h01234' }
  given(:password) { 'password' }
  given!(:user) { create :user, ecampus_id: id, password: password }
  given!(:user_session) { create :user_session, user: user }

  given(:section) { create :section }
  given(:absence) { create :absence, section: section }

  context 'when user HAS absences' do
    before :each do
      user_session.absences << absence
    end

    scenario 'on dashboard home', js: true do
      sign_in_with id, password

      expect(page).to have_content "Absences #{user_session.title}"
      expect(page).to have_selector '#absences-chart svg'
    end

    scenario 'on absences page', js: true do
      sign_in_with id, password
      visit dashboard_absences_path ecampus_id: user.ecampus_id, year: user_session.year, try: user_session.try

      expect(page).to have_content "Absences #{user_session.title}"
      expect(page).to have_selector '#absences-chart svg'
      expect(page).to have_content section.name
      expect(page).to have_content absence.justification
    end

  end

  context 'when user does NOT have absences' do

    scenario 'on dashboard home', js: true do
      sign_in_with id, password

      expect(page).to have_content "Absences #{user_session.title}"
      expect(page).to have_content 'Aucune absence pour l\'instant.'
      expect(page).not_to have_selector '#average-absences svg'
    end

    scenario 'on grades page', js: true do
      sign_in_with id, password
      visit dashboard_absences_path ecampus_id: user.ecampus_id, year: user_session.year, try: user_session.try

      expect(page).to have_content 'Aucune absence ... pour le moment'
      expect(page).not_to have_selector '#absences-chart'
    end
  end

  context 'check feature flags' do
    scenario 'when updates are disabled', js: true do
      Feature.disable_update_absences
      sign_in_with id, password
      visit dashboard_absences_path ecampus_id: user.ecampus_id, year: user_session.year, try: user_session.try

      expect(page).to have_content Feature.update_absences_error_message
    end

    scenario 'when updates are enabled', js: true do
      Feature.enable_update_absences
      sign_in_with id, password
      visit dashboard_absences_path ecampus_id: user.ecampus_id, year: user_session.year, try: user_session.try

      expect(page).not_to have_content Feature.update_absences_error_message
    end
  end
end