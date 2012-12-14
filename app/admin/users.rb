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

    active_admin_comments
  end
end
