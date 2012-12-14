ActiveAdmin.register Course do
  index do
    column :id
    column :name
    column :date
    column :length
    column :week_rev
    column :kind
    column :updated_at
    default_actions
  end
end
