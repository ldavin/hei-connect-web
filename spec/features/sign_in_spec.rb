# encoding: utf-8

require 'spec_helper'

feature 'Visitor signs in' do

  before :each do
    Feature.where(key: 'user_login', enabled: true, error_message: 'Le login est désactivé ma poule!').first_or_create
    sign_out
    user.user_ok!
  end

  given(:id) { 'h01234' }
  given(:valid_password) { 'password' }
  given(:invalid_password) { 'kikoolol' }
  given!(:user) { create :user, ecampus_id: id, password: valid_password }

  scenario 'with valid id and password for a valid user' do
    sign_in_with id, valid_password

    expect(page).to have_content 'Dashboard'
    expect(page).to have_content id
  end

  scenario 'with invalid password for a valid user' do
    sign_in_with id, invalid_password

    expect(page).to have_content 'Identifiants erronés'
  end

  scenario 'with valid id and password for an invalid user' do
    user.user_failed!
    sign_in_with id, valid_password

    expect(page).to have_content 'Les identifiants que vous avez entré ne permettent pas de vous connecter à e-campus'
    expect(User.count).to be 0
  end

  scenario 'when user login is disabled' do
    Feature.disable_user_login
    sign_in_with id, valid_password

    expect(page).not_to have_content 'Dashboard'
    expect(page).to have_content Feature.user_login_error_message
  end

end