module Preview
  class Svn
    
    def self.co(config, names)
      url      = "#{config[:svn_repos]}/#{names.document_root}/trunk"
      doc_root = "#{config[:locations][:vhosts]}/#{names.document_root}"
      system "svn co #{url} #{doc_root}"
    end
    
  end
end
    