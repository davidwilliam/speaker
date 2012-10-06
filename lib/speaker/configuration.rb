module Speaker

  class Configuration
    attr_accessor :audio_file_path

    def initialize
      @audio_file_path = Dir.pwd
    end
  end

end