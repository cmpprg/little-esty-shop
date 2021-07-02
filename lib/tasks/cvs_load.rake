require 'csv'
namespace :csv_load do

  desc "Eager Load resources"
  task eager_load: :environment do |task|
    Rails.application.eager_load!
  end

  desc "Load all the cvs data from ./db/data/customers.csv"
  task customers: :eager_load do |task|
    load_resources_for(task)
  end

  desc "Load all the cvs data from ./db/data/merchants.csv"
  task merchants: :eager_load do |task|
    load_resources_for(task)
  end

  desc "Load all the cvs data from ./db/data/items.csv"
  task items: :eager_load do |task|
    load_resources_for(task)
  end

  desc "Load all the cvs data from ./db/data/invoices.csv"
  task invoices: :eager_load do |task|
    load_resources_for(task)
  end

  desc "Run all rake tasks in csv_load namespace"
  task all: [:customers, :merchants, :items, :invoices]

private

  def load_resources_for(task)
    table_name = task.name.split(':').last
    clear_db_for(table_name)
    load_csv_records_for(table_name)
    reset_pk_sequence_for(table_name)
  end

  def clear_db_for(table_name)
    sql_command = "TRUNCATE #{table_name} CASCADE"
    ActiveRecord::Base.connection.execute(sql_command)
  end

  def load_csv_records_for(table_name)
    csv_options = {headers: true, header_converters: :symbol}

    puts "Loading #{table_name.capitalize}..."
    CSV.foreach(file_path_for(table_name), 'r', csv_options) do |line|
      get_model(table_name).create(line.to_h)
    end
  end

  def file_path_for(table_name)
    root = File.expand_path(File.dirname(__FILE__))
    File.join(root, '..', '..', 'db', 'data', "#{table_name}.csv")
  end

  def get_model(table_name)
    model_name = table_name.classify
    models = ActiveRecord::Base.descendants
    models.find {|model| model.name == model_name}
  end

  def reset_pk_sequence_for(table_name)
    ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
  end
end