namespace :db do

  desc 'Dumps the entire database to an sql file.'
  task :dump => :environment do
    # Fetch DB credentials
    db_config = Rails.configuration.database_configuration
    user = db_config[Rails.env]['username']
    password = db_config[Rails.env]['password']
    host = db_config[Rails.env]['host']
    database = db_config[Rails.env]['database']

    # Prepare filename
    shortname = "#{Time.now.strftime('%Y-%m-%d')}.sql"
    filename = "$OPENSHIFT_DATA_DIR/dumps/#{Rails.env}-#{shortname}"

    # Prepare dump command
    command = 'mysqldump'
    command += ' --add-drop-table'
    command += " -u #{user}"
    command += " -h #{host}" unless host.blank?
    command += " -p#{password}" unless password.blank?
    command += " #{database}"
    command += " > #{filename}"
    # Run dump command
    sh command

    # Run dropbox backup command
    sh "$OPENSHIFT_REPO_DIR/script/dropbox_uploader.sh upload #{filename} #{shortname}"
  end

end