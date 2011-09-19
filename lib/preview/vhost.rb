require 'erb'
require 'fileutils'

module PreviewAdd
  class Vhost
    
    include FileUtils
    
    attr_accessor :vhost
    
    def initialize(config, names)
      @host = config[:host]
      
      @config = config
      @names = names
      
      @auth_name      = 'TODO'
      @auth_user_file = auth_user_file
      @document_root  = File.join(@config[:locations][:vhosts], @names.document_root)
      @server_name    = "#{@names.server_name}.#{@config[:preview_domain]}"
    end
    
    def auth_user_file
      htpasswd_dir = @config[:locations][:htpasswd];
      extension = '.htpasswd'
      auth_user_file = File.join(htpasswd_dir, "#{@names.domain + extension}")

      unless @config[:htpasswd].nil?
        if @config[:htpasswd].end_with?(extension)
          auth_user_file = File.join(htpasswd_dir, "#{@config[:htpasswd]}")
        else
          auth_user_file = File.join(htpasswd_dir, "#{@config[:htpasswd] + extension}")
        end
      end

      auth_user_file
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
        username = @config[:username] || @names.base_name
        password = @config[:password] || nil
        
        if password.nil?
          puts "No htpasswd file exists."
          puts "Username: #{username}"
          print "Password: "
          password = gets.to_s.strip
        end
        
        File.open(@auth_user_file, 'w') { |f| f.write(htpasswd(username, password)) }
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