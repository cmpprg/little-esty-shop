require 'csv'
namespace :csv_load do
  ROOT = File.expand_path(File.dirname(__FILE__))

  desc "I will load all the cvs data from ./db/data/customers.csv"
  task customers: :environment do
    file_path = clear_db_and_return_file_path_for('customers')

    puts "Loading Customers..."
    CSV.foreach(file_path, 'r', headers: true, header_converters: :symbol) do |line|
      Customer.create(line.to_h)
    end

    reset_pk_sequence_for('customers') 
  end

private

  def clear_db_and_return_file_path_for(table_name)
    sql_command = "TRUNCATE #{table_name} RESTART IDENTITY"
    ActiveRecord::Base.connection.execute(sql_command)

    File.join(ROOT, '..', '..', 'db', 'data', "#{table_name}.csv")
  end

  def reset_pk_sequence_for(table_name)
    ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
  end
end