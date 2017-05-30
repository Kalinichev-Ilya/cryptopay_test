require 'yaml'

# Wrapper over secure.yml
class Config
  @config = YAML.load_file('secure.yml')

  def self.uri
    @uri = @config['uri']
  end

  def self.uuid(currency)
    @uuid = @config['UUID'][currency.to_s]
  end

  def self.auth_key
    @key = @config['X-Api-Key']
  end
end
