ActiveAdmin.register Section do
  menu priority: 6

  filter :id
  filter :name
  filter :updated_at
  filter :created_at
end
