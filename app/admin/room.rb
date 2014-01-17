ActiveAdmin.register Room do
  menu priority: 4, parent: 'Courses'

  filter :id
  filter :name
  filter :updated_at
  filter :created_at
end
