ActiveAdmin.register Section do
  menu priority: 7

  filter :id
  filter :name
  filter :updated_at
  filter :created_at
end
