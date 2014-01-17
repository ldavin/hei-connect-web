ActiveAdmin.register Exam do
  menu priority: 1, parent: 'Exams'

  filter :id
  filter :section
  filter :name
  filter :date
  filter :kind
  filter :weight
  filter :average
  filter :updated_at
  filter :created_at

  controller do
    def scoped_collection
      resource_class.includes(:section)
    end
  end

  index do
    selectable_column
    column :id
    column :name
    column 'Section Name', sortable: 'sections.name' do |course|
      link_to course.section.name, admin_section_path(course.section)
    end
    column :weight
    column :average
    column :grades_count
    column :date
    default_actions
  end
end
