require 'yaml'

module PreviewAdd
  
  class Config
    
    FILE = "/etc/preview_add"
    
    def self.config
      if File.exist?(FILE)
        YAML.load_file(FILE)
      else
        puts "Please create a config file in /etc/preview_add"
        exit 1
      end
    end

  end

end