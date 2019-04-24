require "test_helper"

module CellularAutomata
  class LifeTest < Minitest::Test
    def test_birth
      assert_transition(
        <<~SEED,
          OO.
          O..
        SEED
        <<~GRID
          OO.
          OO.
        GRID
      )
    end

    def test_stability
      assert_transition(
        <<~SEED,
          OO.
          OO.
        SEED
        <<~GRID,
          OO.
          OO.
        GRID
      )
    end

    def test_overcrowding
      assert_transition(
        <<~SEED,
          OOO
          OOO
        SEED
        <<~GRID.strip,
          O.O
          O.O
        GRID
      )
    end

    def test_underpopulation
      assert_transition(
        <<~SEED,
          .O.
          .O.
        SEED
        <<~GRID
          ...
          ...
        GRID
      )
    end

    def test_blinker
      assert_transition(
        <<~SEED,
          .O.
          .O.
          .O.
        SEED
        <<~GRID
          ...
          OOO
          ...
        GRID
      )
    end

    def test_glider
      assert_transition(
        <<~SEED,
          .O..
          ..O.
          OOO.
          ....
        SEED
        <<~GRID
          ....
          O.O.
          .OO.
          .O..
        GRID
      )
    end


  private

    def assert_transition(seed, next_state)
      grid = CellularAutomata::Grid.new(rules: CellularAutomata::Rules::Life, seed: seed.strip)
      assert_equal(next_state.strip, grid.next)
    end
  end
end
