#!/usr/bin/ruby
require 'yaml'
require 'json'

error_array = Array.new
begin
  Dir["/build/data/**/*.yaml"].each do |hiera_file|
    hiera_data = YAML.load_file(hiera_file)
    hiera_data.each_key { |key| error_array << "#{key} in #{hiera_file} is not an allowed Hiera key" unless ['variables','profile','puppet_enterprise','pe_r10k','pe_repo','lookup_options'].include?(key.split('::').first)  }
  end
rescue SyntaxError => e
  puts "#{hiera_file} failed to load"
  error_array << "#{hiera_file} failed to load"
end
if error_array.count > 0
  puts error_array
  exit 1
else
  puts 'No unauthorised keys found'
end
