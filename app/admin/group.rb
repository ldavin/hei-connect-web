ActiveAdmin.register Group do
  menu priority: 2, parent: 'Courses'

  filter :id
  filter :name
  filter :updated_at
  filter :created_at
end
