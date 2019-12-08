require 'csv'

module Foretell
  module Crystalball
    class MapStorage
      class Neo4jStorage
        attr_reader :path

        class << self
          def load
          end
        end

        def clear!
        end

        def dump(data)
          return if data[:type] # skip metadata for now

          Tempfile.create do |file|
            CSV.open(file, 'w') do |csv|
              data.each do |example, files_affected|
                files_affected.each do |f|
                  csv << [example, f]
                end
              end
            end

            load_csv(file.path)
          end
        end

        private

        def load_csv(file_path)
          neo4j_client.connection.query(
            <<~QUERY
              USING PERIODIC COMMIT
              LOAD CSV FROM 'file:///#{file_path}' AS line
              MERGE (example:Example {id: line[0]})
              MERGE (file:File {name: line[1]})
              MERGE (example)-[:interacts_with]->(file)
            QUERY
          )
        end

        def neo4j_client
          @neo4j_client ||= Neo4jClient.new
        end
      end
    end
  end
end
