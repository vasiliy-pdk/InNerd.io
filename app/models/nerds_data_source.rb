class NerdsDataSource
  # @TODO: Wrap Octokit::NotFound exception into NerdsDataSource::NotFound
  def self.find(user_name)
    with_respect_to_not_found { client.user(user_name) }
  end
  
  def self.primary_languages(user_name)
    with_respect_to_not_found { client.repositories(user_name).map(&:language) }
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
