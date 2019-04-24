require "test_helper"

module CellularAutomata
  class MockRules; end

  class GridTest < Minitest::Test
    def test_initialization
      grid = Grid.new(rules: MockRules, seed: "OOO\n")
      assert_equal(MockRules, grid.rules)
      assert_equal("OOO", grid.seed)
      assert_equal(30, grid.width)
      assert_equal(20, grid.height)
    end

    def test_bracket_notation
      grid = Grid.new(rules: MockRules, width: 3, height: 3, seed: <<~SEED)
        123
        456
        789
      SEED
      assert_equal("1", grid[ 0,  0])
      assert_equal("2", grid[ 1,  0])
      assert_equal(nil, grid[-1, -1])
      assert_equal("9", grid[ 2,  2])
    end

    def test_neighbors
      grid = Grid.new(rules: MockRules, width: 3, height: 3, seed: <<~SEED)
        123
        456
        789
      SEED
      assert_equal(%w(1 2 3 4 6 7 8 9), grid.neighbors(1,1))
    end
  end
end

