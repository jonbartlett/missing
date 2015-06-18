require 'pry'
require_relative '../lib/photo'
require_relative '../lib/library'
require_relative '../lib/options'
require_relative '../lib/ui'

options = Options::ConfigurationParser.parse(ARGV)
UI::Banner.print

# index master library
master_lib = Missing::Library.new()
master_lib.build(options[:libpath])
 
# index possible dups library
dup_lib = Missing::Library.new()
dup_lib.build(options[:duppath])

# compare both libraries and return new files less duplicates
new_lib = master_lib.diff(dup_lib)


binding.pry
