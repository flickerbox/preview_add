require 'rubygems'
require 'zerigo_dns'

module Preview
  class Dns
    
    def initialize(options = {})
      Zerigo::DNS::Base.user     = options[:user]
      Zerigo::DNS::Base.password = options[:api_key]
      Zerigo::DNS::Base.format   = :xml

      @zone_id = options[:zone_id]
      @host    = options[:host]
      @cname   = options[:cname]
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
      hosts = Zerigo::DNS::Host.find(:all, :params=>{:zone_id => @zone_id)
      hosts.any? { |hash| hash.hostname == hostname }
    end
    
  end
end

options = {}
options[:user]    = ''
options[:api_key] = ''
options[:zone_id] = '2107642932'
options[:host]    = 'test_hossdssst32fs'
options[:cname]   = 'benubois.com'

dns = Preview::Dns.new(options)

unless dns.record_exists? options[:host]
  dns.add_cname
end
