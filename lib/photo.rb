require 'digest/md5'
require 'exifr'

module Missing
  class Photo < File 

    attr_reader :md5, :exif
    attr_accessor :dup

    def initialize (path)
      super(path, 'r')
      @exif = fetch_exif_date
      @md5 = fetch_md5
      @dup = nil
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

    def fetch_exif_date
      begin
        exif = EXIFR::JPEG.new(self.path)
      rescue EXIFR::MalformedJPEG=>e
        exif == nil
      end
    end
  end
end
