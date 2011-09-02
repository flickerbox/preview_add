require 'fileutils'
require 'yaml'
require 'pp'

module Preview
  
  class Config
    
    include FileUtils
    
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

# config = Preview::Config.config
# pp config
# 
# puts config[:zerigo][:api_key]