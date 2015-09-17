# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Rails.logger = Le.new('b6936c9f-379e-4eff-83a4-3130249e1e04', :debug => true, :local => true)
