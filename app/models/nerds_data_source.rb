class NerdsDataSource
  
  def self.find(user_name)
    with_respect_to_not_found { client.user(user_name) }
  end
  
  def self.primary_languages(user_name)
    with_respect_to_not_found { own_repositories(user_name).map(&:language) }
  end
  
  def self.own_repositories(user_name)
    client.repositories(user_name).reject { |repository| repository[:fork] == true }
  end

  class << self
    private
    
    def client
      @client ||= Octokit::Client.new(:access_token => ENV['GITHUB_API_ACCESS_TOKEN'])
    end

    def with_respect_to_not_found
      yield
    rescue Octokit::NotFound => e
      raise NotFound.new(e.message)
    end
  end

  class Error < RuntimeError
  end

  class NotFound < Error
  end
end
