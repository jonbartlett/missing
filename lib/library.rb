require_relative '../lib/photo'

module Missing
  class Library

    attr_accessor :path
    attr_reader :photos

    def initialize(path)
     @path = path
     @photos = [] 
     # create hash of photo directory contents, adding MD5 string, photo name.
     # loops recursively through photo directory
     Dir.chdir(@path)
     Dir['**/*.*'].each do |file|
       filepath = "#{@path}/#{file}".gsub('//','/')
       # Ignore non-existent files (symbolic links) and directories.
       next if !File.exists?("#{filepath}") || File.directory?("#{filepath}")
       @photos.push Photo.new(filepath)
     end
     
    end
  end
end
