module PreviewAdd
  class Names
    
    attr_reader :document_root, :domain, :server_name, :host, :base_name
    
    def initialize(host)
      @host = host.dup
      @host.gsub!(/^(https?:\/\/)?(www\.)?/, '')
      
      parts          = @host.split('.')
      @document_root = parts.reverse.join('.')
      @domain        = parts[-2, 2].reverse.join('.')
      @server_name   = parts[0..-2].join('.')
      @base_name     = parts[-2]
    end
    
  end
end