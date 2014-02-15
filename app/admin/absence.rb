ActiveAdmin.register Absence do
  menu priority: 6

  filter :id
  filter :section
  filter :date
  filter :length
  filter :excused
  filter :justification
  filter :updated_at
  filter :created_at

  controller do
    def scoped_collection
      resource_class.includes(:section, user_session: :user)
    end
  end

  index do
    selectable_column
    column :id
    column 'Section Name', sortable: 'sections.name' do |absence|
      link_to absence.section.name, admin_section_path(absence.section)
    end
    column :length
    column 'Excused', sortable: :excused do |absence|
      status_tag(absence.excused.to_s, (absence.excused ? :ok : :warn)) if absence.excused.present?
    end
    column :justification
    column :date
    column 'User', sortable: 'user_sessions.user_id' do |grade|
      link_to grade.user, admin_user_path(grade.user)
    end
    column 'User Session' do |grade|
      link_to grade.user_session.title, admin_user_session_path(grade.user_session)
    end
    default_actions
  end
end
