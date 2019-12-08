require 'neo4j/core'
require 'neo4j/core/cypher_session/adaptors/http'

module Foretell
  class Neo4jClient
    attr_reader :connection

    def initialize(adaptor: nil)
      adaptor ||= http_adaptor
      @connection = Neo4j::Core::CypherSession.new(adaptor)
    end

    private

    def http_adaptor
      server_url = ENV['NEO4J_URL'] || 'http://neo4j:batata@localhost:7474'
      Neo4j::Core::CypherSession::Adaptors::HTTP.new(server_url)
    end
  end
end
