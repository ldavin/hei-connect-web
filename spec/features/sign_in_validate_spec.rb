require 'spec_helper'

feature 'Visitor being validated signs in' do

  before :each do
    Feature.enable_user_login
    sign_out
    user.user_updating!
  end

  given(:id)       { 'h01234' }
  given(:password) { 'password' }
  given!(:user) { create :user, ecampus_id: id, password: password}

  scenario 'waits when status is updating' do
    sign_in_with id, password

    expect(page).to have_content 'Premier Login'
  end

  scenario 'waits when status is scheduled' do
    user.user_scheduled!
    sign_in_with id, password

    expect(page).to have_content 'Premier Login'
  end

  scenario 'is redirected when status is ok' do
    sign_in_with id, password
    expect(page).to have_content 'Premier Login'

    user.user_ok!
    visit validate_users_path

    expect(page).to have_content 'Dashboard'
    expect(page).to have_content id
  end

  scenario 'is deleted when status is unknown' do
    sign_in_with id, password
    expect(page).to have_content 'Premier Login'

    user.user_unknown!
    visit validate_users_path
    expect(page).to have_content 'Login'
    expect(User.count).to be 0
  end

  scenario 'is deleted when status is failed' do
    sign_in_with id, password
    expect(page).to have_content 'Premier Login'

    user.user_failed!
    visit validate_users_path
    expect(page).to have_content 'Login'
    expect(User.count).to be 0
  end

end