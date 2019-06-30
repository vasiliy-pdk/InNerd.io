class NerdsDataSource
  def self.find(user_name)
    client.user(user_name)
  end
  
  def self.primary_languages(user_name)
    client.repositories(user_name).map(&:language)
  end
  
  class << self
    private
    
    def client
      @client ||= Octokit::Client.new(:access_token => 'b52e15a2dfd0ff9cd2bd6027b478fe70c0d3cdf2')
    end
  end
end
