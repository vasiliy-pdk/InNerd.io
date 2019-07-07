require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = File.join(__dir__, 'fixtures', 'vcr_cassettes')
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.filter_sensitive_data('<GITHUB_API_ACCESS_TOKEN>') { ENV['GITHUB_API_ACCESS_TOKEN'] }
end
