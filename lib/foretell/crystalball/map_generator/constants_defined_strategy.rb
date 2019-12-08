require 'crystalball/map_generator/parser_strategy'

module Foretell
  module Crystalball
    module MapGenerator
      class ConstantsDefinedStrategy < ::Crystalball::MapGenerator::ParserStrategy
        def after_register
          Tempfile.create do |file|
            CSV.open(file, 'w') do |csv|
              files_to_inspect.each do |path|
                processor.consts_defined_in(path).each do |const|
                  csv << [path.sub("#{root_path}/", ''), const]
                end
              end
            end

            Neo4jClient.new.connection.query(
              <<~QUERY
                USING PERIODIC COMMIT
                LOAD CSV FROM 'file:///#{file.path}' AS line
                MERGE (file:File {path: line[0]})
                MERGE (const:Const {name: line[1]})
                MERGE (file)-[:defines]->(const)
                MERGE (const)-[:is_defined_in]->(file)
              QUERY
            )
          end
        end

        # Just skip it. Only +after_register+ is needed in this strategy.
        def call(example_map, example)
          yield example_map, example
        end
      end
    end
  end
end
