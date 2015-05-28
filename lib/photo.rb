require 'digest/md5'
require 'exifr'

module Missing
  class Photo < File 

    attr_reader :md5, :exif

    def initialize (path)
      super(path, 'r')
      @exif = fetch_exif
      @md5 = fetch_md5
    end

    private  # all methods that follow will be made private: not accessible for outside objects

    def fetch_md5
      # Create a hash digest for the current file.
      digest = Digest::MD5.new
      File.open(self, 'r') do |handle|
        while buffer = handle.read(1024)
          digest << buffer
        end
      end
      digest
    end

    def fetch_exif
      begin
        exifr_date = EXIFR::JPEG.new(self.path).date_time
      rescue EXIFR::MalformedJPEG=>e
        exifr_date == nil
      end
    end
  end
end
