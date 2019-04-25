require "test_helper"

module CellularAutomata
  class GameTest < Minitest::Test
    def test_initialization
      grid = Grid.new(width: 30, height: 20, empty: ".")
      game = Game.new(rules: rules_mock, grid: grid)
      assert_equal(rules_mock, game.rules)
      assert_equal(grid, game.grid)
    end 

    def test_next
      grid = Grid.new(width: 3, height: 1, empty: ".")
      game = Game.new(rules: rules_mock, grid: grid)

      assert_equal("...", game.grid.to_s)
      rules_mock.stub(:call, "!") do
        game.next
        assert_equal("!!!", game.grid.to_s)
      end
    end

    def test_plant_seed
      grid = Grid.new(width: 3, height: 3)
      game = Game.new(rules: rules_mock, grid: grid)

      assert_equal(<<~GRID.strip, game.grid.to_s)
        ...
        ...
        ...
      GRID
 
      game.plant_seed(<<~SEED)
        OO
        OO
      SEED

      assert_equal(<<~GRID.strip, game.grid.to_s)
        OO.
        OO.
        ...
      GRID
    end

  private

    def rules_mock
      @rules_mock ||= ->(**args) {}
    end
  end
end

