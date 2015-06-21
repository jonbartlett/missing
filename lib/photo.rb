require 'digest/md5'
require 'exifr'

module Missing
  class Photo 

    attr_reader :md5, :exif, :path
    attr_accessor :dup

    def initialize (path)
      @path = path
      @exif_date = fetch_exif_date
      @md5 = fetch_md5
    end

    private  # all methods that follow will be made private: not accessible for outside objects

    def fetch_md5
      # Create a hash digest for the current file.
      digest = Digest::MD5.new
      File.open(@path, 'r') do |handle|
        while buffer = handle.read(1024)
          digest << buffer
        end
      end
      digest
    end

    def fetch_exif_date
      begin
        EXIFR::JPEG.new(self.path) do |p|
          p.date_time
        end
      rescue EXIFR::MalformedJPEG=>e
        exif == nil
      end
    end
  end
end
