require 'erb'

module Preview
  class Vhost
    
    def initialize(options)
      @auth_name      = options[:auth_name]
      @auth_user_file = options[:auth_user_file]
      @document_root  = options[:document_root]
      @server_name    = options[:server_name]
    end
    
    def generate_vhost
      file = File.join(File.expand_path(File.dirname(__FILE__)), 'vhost.erb')
      vhost = ERB.new(File.read(file))
      vhost.result(binding)
    end
    
    def htpasswd
      `htpasswd -bn test test`
    end
    
  end
end

options = {
  :auth_name      => 'Flickerbox',
  :auth_user_file => 'com.flickerbox',
  :document_root  => 'com.flickerbox',
  :server_name    => 'flickerbox.flickerbox.com'
}
vhost = Preview::Vhost.new(options)

# puts vhost.generate_vhost
puts vhost.htpasswd