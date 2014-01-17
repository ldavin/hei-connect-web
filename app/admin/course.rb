ActiveAdmin.register Course do
  menu priority: 1, parent: 'Courses'

  filter :id
  filter :rooms
  filter :teachers
  filter :users
  filter :section
  filter :group
  filter :date
  filter :length
  filter :kind
  filter :broken_name
  filter :updated_at
  filter :created_at

  controller do
    def scoped_collection
      resource_class.includes(:section, :group)
    end
  end

  index do
    selectable_column
    column :id
    column :ecampus_id
    column 'Section Name', sortable: 'sections.name' do |course|
      link_to course.section.name, admin_section_path(course.section)
    end
    column 'Group', sortable: 'groups.name' do |course|
      link_to course.group.name, admin_group_path(course.group)
    end
    column :kind
    column :broken_name
    column :length
    column :date
    default_actions
  end
end
