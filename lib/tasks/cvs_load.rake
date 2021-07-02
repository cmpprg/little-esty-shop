require 'csv'
namespace :csv_load do
  ROOT = File.expand_path(File.dirname(__FILE__))

  desc "I will load all the cvs data from the db/data directory"
  task :customers do
    file_path = File.join(ROOT, '..', '..', 'db', 'data', 'customers.csv')

    CSV.foreach(file_path, 'r') do |line|
      puts line
    end
    require 'pry';binding.pry
    # ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end
end