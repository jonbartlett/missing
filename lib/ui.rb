require 'singleton'

module UI

  class Progress
    include Singleton

    def self.index_update(counter, total)
      print "\r  Indexing library... #{counter} of #{total}: #{format("%.2f",(counter.to_f / total.to_f)*100) }%"
      print "\n" if counter == total 
    end
    
    def self.diff_update(counter, total)
      print "\r  Comparing files.... #{counter} of #{total}: #{format("%.2f",(counter.to_f / total.to_f)*100) }%"
      print "\n" if counter == total 
    end

    def self.diff_results(new_count, dup_count)
      puts "  New files       : #{new_count}"
      puts "  Duplicate files : #{dup_count}"
      puts
    end

    def self.update(msg)
      print "#{msg}\n"
    end
  end

  class Banner
    include Singleton

    def self.print
     puts " Missing"
    end
  end

end
