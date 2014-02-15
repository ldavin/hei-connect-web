ActiveAdmin.register Feature do

  config.sort_order = 'key_asc'

  menu priority: 2

  scope :all
  scope :enabled do |features|
    features.where(enabled: true)
  end
  scope :disabled do |features|
    features.where(enabled: [false, nil])
  end

  index do
    column :id
    column :key, :sortable => :enabled
    column :state, :sortable => :enabled do |f|
      s = (f.enabled ? 'Disable' : 'Enable')
      link_name = link_to((f.enabled ? 'enabled' : 'disabled'), toggle_admin_feature_path(f), method: :post, confirm: "#{s} #{f.key}?")

      status_tag f.enabled.to_s, :label => link_name
    end
    column :updated_at

    default_actions
  end

  member_action :toggle, :method => :post do
    f = Feature.find params[:id]
    f.toggle! :enabled
    redirect_to action: :index
  end


end