require_relative '../lib/photo'

module Missing
  class Library

    attr_accessor :photos

    def initialize
     @photos = [] 
    end

    def build(path)
     file_count = 0
     progress_count = 0

     # create hash of photo directory contents, adding MD5 string, photo name.
     # loops recursively through photo directory
     Dir.chdir(path)

     # first loop through dir to get file count
     Dir['**/*.*'].each do |file, index|
       filepath = "#{path}/#{file}".gsub('//','/')
       # Ignore non-existent files (symbolic links) and directories.
       next if !File.exists?("#{filepath}") || File.directory?("#{filepath}")
       file_count =+ 1
     end
     
     print "Indexing library:  0%"

     Dir['**/*.*'].each do |file, index|
       filepath = "#{path}/#{file}".gsub('//','/')
       # Ignore non-existent files (symbolic links) and directories.
       next if !File.exists?("#{filepath}") || File.directory?("#{filepath}")
       @photos.push Photo.new(filepath)
       progress_count =+ 1
       print "\b\b#{(progress_count / file_count) }%"
     end

     puts
     
    end
    
    # given Libary object returns this minus receiver Library object based on photos MD5
    # possible replace with more efficient code 
    #  http://stackoverflow.com/questions/11427282/best-way-to-compare-two-array-of-objects-in-rails
    def diff (lib)

      new_lib = Missing::Library.new()
      dup_lib = Missing::Library.new()

      # loop through Library object passed
      lib.photos.each_with_index do | lib_passed_photo, index |
        # loop through this Library object photos
        @photos.each_with_index do | lib_self_photo, inner_index |
          # if matching file found (duplicate) 
          if lib_passed_photo.md5 == lib_self_photo.md5   
            dup_lib.photos.push lib_passed_photo
            dup_lib.photos[-1].dup = lib_self_photo
            break 
          end
          # if last iteration (i.e. no match found)
          if inner_index+1 == @photos.count
            new_lib.photos.push lib_passed_photo 
          end
        end 
      end
      {:new_lib => new_lib, :dup_lib => dup_lib}
    end
    # copies photos from Missing::Photo filepath to Missing::Library @path
    def relocate

    end

  end
end
