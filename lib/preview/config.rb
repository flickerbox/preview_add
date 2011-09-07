require 'yaml'

module Preview
  
  class Config
    
    FILE = "/etc/preview"
    
    def self.config
      if File.exist?(FILE)
        YAML.load_file(FILE)
      else
        puts "Please create a config file in /etc/preview"
        exit 1
      end
    end

  end

end