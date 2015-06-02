require 'optparse'
require 'singleton'

module Options

  class ConfigurationParser
    include Singleton

    def self.parse(args)
      options = {}

      OptionParser.new do |opts|
        opts.banner = "Usage: missing.rb [options]"
        opts.separator ""
        opts.on('-l', '--libpath PATH', 'path to master library') { |v| options[:libpath] = v }
        opts.on('-d', '--duppath PATH', 'path to possible duplicates') { |v| options[:duppath] = v }
        opts.on('-r', '--[no]rename', 'Rename to DropBox format') { |v| options[:rename] = v}

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        begin
          opts.parse!
          mandatory = [:libpath, :duppath]
          missing = mandatory.select{ |param| options[param].nil? }

          unless missing.empty?
            puts "Missing options: #{missing.join(', ')}" 
            puts opts
            exit  
          end

          # validate paths exist
          unless File.directory?(options[:libpath])
            puts "-l   --libpath is not a valid directory"
            exit
          end

          unless File.directory?(options[:duppath])
            puts "-d   --duppath is not a valid directory"
            exit
          end

        rescue OptionParser::InvalidOption, OptionParser::MissingArgument
          puts $!.to_s
          puts opts
          exit
        end
      end
      options

    end


  end
end
