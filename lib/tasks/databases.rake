namespace :db do
  desc 'Populate database with dummy data.'
  task :bootstrap => :environment do
    require 'active_record/fixtures'
    fixtures_folder = Rails.root.join('db', 'bootstrap')
    fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
    Fixtures.create_fixtures(fixtures_folder, fixtures)
  end
end
