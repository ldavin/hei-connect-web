# encoding: utf-8

require 'spec_helper'

feature 'Visitor signs in' do

  before :each do
    sign_out
    user.user_ok!
  end

  given(:id)               { 'h01234' }
  given(:valid_password)   { 'password' }
  given(:invalid_password) { 'kikoolol' }
  given!(:user) { create :user, ecampus_id: id, password: valid_password}

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

end