class Nerd
  attr_reader :login

  def self.find(user_name)
    found_data = NerdsDataSource.find user_name
    Nerd.new(found_data.login) if found_data
  end

  def initialize(login)
    @login = login
  end

  def favourite_language
    languages = NerdsDataSource.primary_languages(login).compact
    return nil if languages.empty?

    totals = Hash.new(0)
    languages.each { |language| totals[language] += 1 }
    totals.keys[totals.values.index(totals.values.max)]
  end
end
