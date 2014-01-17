ActiveAdmin.register Grade do
  menu priority: 2, parent: 'Exams'

  filter :id
  filter :mark
  filter :unknown
  filter :updated_at
  filter :created_at

  controller do
    def scoped_collection
      resource_class.includes(user_session: :user)
    end
  end

  index do
    selectable_column
    column :id
    column :mark
    column 'Unknown', sortable: :unknown do |grade|
      status_tag grade.unknown.to_s, (grade.unknown ? :warn : :ok)
    end
    column 'Exam', sortable: :exam_id do |grade|
      link_to "Exam #{grade.exam_id}", admin_exam_path(grade.exam_id)
    end
    column 'User', sortable: 'user_sessions.user_id' do |grade|
      link_to grade.user, admin_user_path(grade.user)
    end
    column 'User Session' do |grade|
      link_to grade.user_session.title, admin_user_session_path(grade.user_session)
    end
    default_actions
  end
end
