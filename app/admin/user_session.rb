ActiveAdmin.register UserSession do
  menu priority: 3, parent: 'Users'

  filter :id
  filter :user
  filter :update_number
  filter :year
  filter :try
  filter :absences_session
  filter :grades_session
  filter :updated_at
  filter :created_at

  controller do
    def scoped_collection
      resource_class.includes(:user)
    end
  end

  index do
    selectable_column
    column :id
    column 'User', sortable: 'users.ecampus_id' do |session|
      link_to session.user.ecampus_id, admin_user_path(session.user)
    end
    column :title, sortable: 'year'
    column :absences_session
    column :grades_session
    column :update_number
    column :updated_at
    default_actions
  end
end
