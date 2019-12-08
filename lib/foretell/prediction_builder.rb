module Foretell
  class PredictionBuilder < ::Crystalball::RSpec::PredictionBuilder
    def expired_map?
      false
    end

    def execution_map
    end

    private

    def predictor
      super do |p|
        p.use Crystalball::Predictor::RelatedExamplesStrategy.new
        p.use ::Crystalball::Predictor::ModifiedSpecs.new
      end
    end
  end
end
