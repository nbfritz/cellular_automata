module CellularAutomata
  class Grid
    attr_reader :seed, :rules

    def initialize(seed: seed, rules: rules)
      @seed, @rules = seed, rules
    end

    def next
      seed
    end
  end
end

