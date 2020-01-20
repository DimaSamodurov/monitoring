require 'vcr'
require 'dotenv/load'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into                :webmock
  c.default_cassette_options = {:record => :new_episodes}
  c.configure_rspec_metadata!

  c.filter_sensitive_data('<AWS_ACCESS_KEY_ID>') do
    ENV['AWS_ACCESS_KEY_ID']
  end
  c.filter_sensitive_data('<AWS_SECRET_ACCESS_KEY>') do
    ENV['AWS_SECRET_ACCESS_KEY']
  end
end
