require 'rubygems'
require 'zerigo_dns'

module Preview
  class Dns
    
    def initialize(options, host)
      Zerigo::DNS::Base.user     = options[:zerigo][:user]
      Zerigo::DNS::Base.password = options[:zerigo][:api_key]
      Zerigo::DNS::Base.format   = :xml
      
      @zone_id = options[:zerigo][:zone_id]
      @host    = host
      @cname   = options[:preview_domain]
    end
    
    def add_cname
      vals = {
        :hostname  => @host,
        :host_type => 'CNAME',
        :data      => @cname,
        :zone_id   => @zone_id
      }
      
      begin
        Zerigo::DNS::Host.create(vals)
      rescue Exception => e
        if e.to_s.include? 'wrong number of arguments (2 for 1)'
          puts "Successfully created #{@host}.#{@cname}"
        else
          puts e
        end
      end
      
    end
    
    def record_exists?(hostname)
      begin
        hosts = Zerigo::DNS::Host.find(:all, :params=>{:zone_id => @zone_id})
        hosts.any? { |hash| hash.hostname == hostname }
      rescue Exception => e
        puts e
        exit 1
      end
    end
    
    def create_if_not_exists
      unless record_exists? @host
        add_cname
      end
    end
    
  end
end