ActiveAdmin.register Teacher do
  menu priority: 3, parent: 'Courses'

  filter :id
  filter :name
  filter :updated_at
  filter :created_at
end
