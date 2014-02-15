ActiveAdmin.register Update do
  menu priority: 2, parent: 'Users'

  scope :all, default: true
  scope :unknown
  scope :scheduled
  scope :updating
  scope :ok
  scope :failed
  scope :disabled

  controller do
    def scoped_collection
      resource_class.includes(:user)
    end
  end

  index do
    selectable_column
    column :id
    column 'User', sortable: 'users.ecampus_id' do |update|
      link_to update.user.ecampus_id, admin_user_path(update.user)
    end
    column :object
    column 'State', sortable: :state do |update|
      status_tag update.state
    end
    column :state
    column :rev
    column :updated_at
    default_actions
  end

end
