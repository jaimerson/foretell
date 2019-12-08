require 'crystalball'
require 'crystalball/map_generator/parser_strategy'
require 'foretell/version'
require 'foretell/neo4j_client'
require 'foretell/crystalball/map_storage/neo4j_storage'
require 'foretell/crystalball/map_generator/constants_defined_strategy'
require 'foretell/crystalball/predictor/related_examples_strategy'
require 'foretell/prediction_builder'

module Foretell
  class Error < StandardError; end
end
