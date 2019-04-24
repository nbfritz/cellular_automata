require "test_helper"

module CellularAutomata
  class RulesForTesting
  end

  class GridTest < Minitest::Test
    def test_initialization
      grid = Grid.new(rules: RulesForTesting, seed: "OOO")
      assert_equal(RuleForTesting, grid.rules)
      assert_equal("OOO", grid.seed)
    end
  end
end


