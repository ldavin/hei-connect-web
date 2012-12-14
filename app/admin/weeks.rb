ActiveAdmin.register Week do
  index do
    column :id
    column :user
    column :number
    column :rev
    column :updated_at
    default_actions
  end
end
