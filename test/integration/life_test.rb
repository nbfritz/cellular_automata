require "test_helper"

module CellularAutomata
  class LifeTest < Minitest::Test
    def test_birth
      assert_transition( 3, 2,
        <<~GRID,
          OO.
          O..
        GRID
        <<~GRID
          OO.
          OO.
        GRID
      )
    end

    def test_stability
      assert_transition(
        3, 2,
        <<~GRID,
          OO.
          OO.
        GRID
        <<~GRID,
          OO.
          OO.
        GRID
      )
    end

    def test_overcrowding
      assert_transition(
        3, 2,
        <<~GRID,
          OOO
          OOO
        GRID
        <<~GRID.strip,
          O.O
          O.O
        GRID
      )
    end

    def test_underpopulation
      assert_transition(
        3, 2,
        <<~GRID,
          .O.
          .O.
        GRID
        <<~GRID
          ...
          ...
        GRID
      )
    end

    def test_blinker
      assert_transition(
        3, 3,
        <<~GRID,
          .O.
          .O.
          .O.
        GRID
        <<~GRID
          ...
          OOO
          ...
        GRID
      )
    end

    def test_glider
      assert_transition(
        4, 4,
        <<~GRID,
          .O..
          ..O.
          OOO.
          ....
        GRID
        <<~GRID
          ....
          O.O.
          .OO.
          .O..
        GRID
      )
    end


  private

    def assert_transition(width, height, seed, next_state)
      grid = CellularAutomata::Grid.new(width: width, height: height)
      game = Game.new(rules: CellularAutomata::Rules::Life, grid: grid)
      game.plant_seed(seed)
      assert_equal(next_state.strip, game.next.to_s)
    end
  end
end

