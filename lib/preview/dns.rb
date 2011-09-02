require 'zerigo_dns'

module Preview
  class Dns
    
    attr_writer :host, :user, :api_key, :zone_id, :cname
    
    def initialize
      @host    = nil
      @user    = nil
      @api_key = nil
      
      Zerigo::DNS::Base.user    = 'test@example.com'
      Zerigo::DNS::Base.api_key = 'ca01ffae311a7854ea366b05cd02bd50'
    end
    
    def add_record
      host = {
        :hostname  => @host,
        :host_type => 'CNAME',
        :data      => @cname,
        :ttl       => 86400,
        :zone_id   => @zone_id
      }
      begin
        newhost = Zerigo::DNS::Host.create(host)
        puts "  Host #{newhost.hostname} created successfully with id #{newhost.id}."
      rescue ResourceParty::ValidationError => e
        puts "  There was an error saving the new host."
        puts e.message.join(', ')+'.'
      end
      
    end
    
    def record_exists?
      
    end
    
  end
end

dns = Preview::Dns.new
dns.user = 'admin@flickerbox.com'
dns.api_key = 'asdfasdfasdf'
dns.host = 'sliderocket'