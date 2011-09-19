require "preview_add/version"
require "preview_add/config"
require "preview_add/names"
require "preview_add/dns"
require "preview_add/vhost"
require "preview_add/svn"

module PreviewAdd
  class PreviewAdd
    
    attr_reader :config, :names
    
    def initialize(opts = {})
      @config = Config.config.merge(opts)
      @names = Names.new(@config[:host])
    end
    
    def add_dns
      dns = Dns.new(@config, @names.server_name)
      dns.create_if_not_exists
    end
    
    def add_vhost
      vhost = Vhost.new(@config, @names)
      vhost.create!
    end
    
    def checkout_site
      Svn.co(@config, @names)
    end
    
    def add_site
      # Add DNS Entry
      add_dns
      
      # Add Vhost
      add_vhost
      
      # Checkout site
      checkout_site
      
    end
    
  end
end
