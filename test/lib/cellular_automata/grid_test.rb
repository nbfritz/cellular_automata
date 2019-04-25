require "test_helper"

module CellularAutomata
  class GridTest < Minitest::Test
    def test_minimal_initialization
      grid = Grid.new

      assert_equal(30, grid.width)
      assert_equal(20, grid.height)
      assert_equal(".", grid.empty)
    end

    def test_from_s
      grid = Grid.from_s(<<~GRID)
        123
        456
        789
      GRID

      assert_equal("1", grid[0, 0])
      assert_equal("5", grid[1, 1])
      assert_equal("9", grid[2, 2])
    end

    def test_from_array
      grid = Grid.from_array([
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"]
      ])

      assert_equal("1", grid[0, 0])
      assert_equal("5", grid[1, 1])
      assert_equal("9", grid[2, 2])
    end


    def test_bracket_notation
      grid = Grid.from_s(<<~GRID)
        123
        456
        789
      GRID

      assert_equal("1", grid[ 0,  0])
      assert_equal("2", grid[ 1,  0])
      assert_equal("9", grid[ 2,  2])
      assert_nil(grid[-1, -1])
      assert_nil(grid[ 3,  3])
    end

    def test_bracket_assignment_notation
      grid = Grid.new(width: 3, height: 3)
      grid[0, 0] = "O"
      grid[1, 1] = "O"
      grid[2, 2] = "O"

      assert_equal(<<~GRID.strip, grid.to_s)
        O..
        .O.
        ..O
      GRID
    end

    def test_neighbors
      grid = Grid.from_s(<<~GRID)
        123
        456
        789
      GRID

      assert_equal(["1", "2", "3", "4", "6", "7", "8", "9"], grid.neighbors(1, 1))
      assert_equal([nil, nil, nil, nil, "2", nil, "4", "5"], grid.neighbors(0, 0))
      assert_equal(["2", "3", nil, "5", nil, "8", "9", nil], grid.neighbors(2, 1))
    end

    def test_apply_transformation
      grid = Grid.from_s(<<~GRID)
        123
        456
        789
      GRID

      assert_equal(["1", "2", "4"], grid.apply_transformation(0, 0, [[ 0, 0], [1, 0], [0, 1]]))
      assert_equal([nil, "3", "7"], grid.apply_transformation(0, 0, [[-2, 0], [2, 0], [0, 2]]))
      assert_equal([nil, nil, nil], grid.apply_transformation(1, 1, [[-2, 0], [2, 0], [0, 2]]))
    end

    def test_to_s
      grid = Grid.new(width: 5, height: 3)

      assert_equal(<<~GRID.strip, grid.to_s)
        .....
        .....
        .....
      GRID
    end

    def test_to_s_with_alt_empty
      grid = Grid.new(width: 3, height: 1, empty: "~")

      assert_equal("~~~", grid.to_s)
    end

  private

    def rules_mock
      @rules_mock ||= ->(**args) {}
    end
  end
end

