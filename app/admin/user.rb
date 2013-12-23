ActiveAdmin.register User do
  menu priority: 1, parent: 'Users'

  index do
    selectable_column
    column :id
    column :ecampus_id
    column :last_activity
    column :updated_at
    column :created_at
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :ecampus_id
      f.input :password
      f.input :ics_key
      f.input :token
    end
    f.actions
  end
end
