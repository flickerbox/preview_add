require 'erb'
require 'fileutils'

module Preview
  class Vhost
    
    include FileUtils
    
    attr_accessor :vhost
    
    def initialize(config, names)
      @host = config[:host]
      
      @config = config
      @names = names
      
      @auth_name      = 'TODO'
      @auth_user_file = File.join(@config[:locations][:htpasswd], "#{@names.domain}.htpasswd")
      @document_root  = File.join(@config[:locations][:vhosts], @names.document_root)
      @server_name    = "#{@names.server_name}.#{@config[:preview_domain]}"
    end

    def generate_vhost
      template = File.join(File.dirname(__FILE__), 'vhost.erb')
      vhost = ERB.new(File.read(template))
      vhost.result(binding)
    end
    
    def htpasswd(username, password)
      `htpasswd -bn #{username} #{password}`
    end
    
    def create!
      # Create the document root
      unless File.exist? @document_root
        mkdir(@document_root)
      end
      
      # Create the vhost
      File.open(File.join(@config[:locations][:sites_available], @names.document_root), 'w') { 
        |f| f.write(generate_vhost) 
      }
      
      # Create the htpasswd file if it doesn't exist
      unless File.exists? @auth_user_file
        puts "No htpasswd file exists."
        puts "Username: #{@names.base_name}"
        print "Password: "
        password = gets.to_s.strip
        
        File.open(@auth_user_file, 'w') { |f| f.write(htpasswd(@names.base_name, password)) }
      end
      
      unless @config[:mode] == 'test'
        # Enable the site
        `a2ensite #{@names.document_root}`

        # reload apache
        `service apache2 reload`
      end
      
    end
    
  end
end

# vhost = Preview::Vhost.new('http://www.flickerbox.com')
# vhost.create!
# vhost = Preview::Vhost.new('http://login.sliderocket.com')
# vhost.create!
# puts vhost.vhost
# vhost = Preview::Vhost.new('blog.sliderocket.com')
# puts vhost.vhost

# puts vhost.generate_vhost
# puts vhost.vhost