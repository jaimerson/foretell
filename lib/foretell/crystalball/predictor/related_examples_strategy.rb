module Foretell
  module Crystalball
    class Predictor
      class RelatedExamplesStrategy
        include ::Crystalball::Predictor::Strategy

        def call(diff, _map)
          super do
            files = diff.map(&:relative_path)
            neo4j_client
              .connection
              .query(BASE_QUERY % files.select { |f| f.end_with?('.rb') }.to_s)
              .rows
              .flatten
          end
        end

        private

        BASE_QUERY = <<~QUERY
          MATCH(file:File)<-[:interacts_with]-(example:Example)
          WHERE file.name IN %s return example.id
        QUERY

        def neo4j_client
          Neo4jClient.new
        end
      end
    end
  end
end
