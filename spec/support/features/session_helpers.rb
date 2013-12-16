module Features
  module SessionHelpers
    def sign_in_with(id, password)
      visit root_path
      fill_in 'Identifiant ecampus', with: id
      fill_in 'Mot de passe', with: password
      click_button 'Connexion'
    end

    def sign_out
      visit sessions_path
    end
  end
end