require 'pry'
require_relative '../lib/photo'
require_relative '../lib/library'
require_relative '../lib/options'

options = Options::ConfigurationParser.parse(ARGV)

master_lib = Missing::Library.new(options[:libpath])
dups_lib = Missing::Library.new(options[:duppath])

binding.pry

