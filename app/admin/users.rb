ActiveAdmin.register User do
  actions :all, :except => [:new]

  scope :all, default: true
  scope :unverified
  scope :active
  scope :schedule_unknown
  scope :schedule_planned
  scope :schedule_ok

  index do
    column :id
    column :ecampus_id
    column :state
    column :schedule_state
    column :created_at
    column :updated_at
    default_actions
  end

  filter :ecampus_id
  filter :state, :as => :select, :collection => User::STATES
  filter :schedule_state, :as => :select, :collection => User::SCHEDULE_STATES
  filter :updated_at
  filter :created_at

  show do
    attributes_table do
      row :id
      row :ecampus_id
      row :state
      row :schedule_state
      row :ics_key
      row :created_at
      row :updated_at
    end

    panel "This user's weeks" do
      table_for(user.weeks) do
        column "ID" do |w|
          link_to w.id, admin_week_path(w)
        end
        column :number
        column :rev
      end
    end

=begin
    Todo: Find a way to collect all the courses and display them
    panel "This user's courses" do
      table_for(user.weeks.collect { |week| week.courses }) do
        column "ID" do |c|
          link_to c.id, admin_course_path(a)
        end
        column :name
        column :date
        column :length
        column :kind
      end
    end
=end

    active_admin_comments
  end
end
