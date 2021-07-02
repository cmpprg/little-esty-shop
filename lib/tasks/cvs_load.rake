require 'csv'
namespace :csv_load do
  ROOT = File.expand_path(File.dirname(__FILE__))

  desc "I will load all the cvs data from the db/data directory"
  task customers: :environment do
    file_path = File.join(ROOT, '..', '..', 'db', 'data', 'customers.csv')

    CSV.foreach(file_path, 'r', headers: true, header_converters: :symbol) do |line|
      require 'pry';binding.pry
    end
    # ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end
end