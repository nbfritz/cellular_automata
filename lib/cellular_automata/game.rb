module CellularAutomata
  class Game
    attr_reader :rules, :grid

    def initialize(rules:, grid:)
      @rules, @grid = rules, grid
    end

    def next
      new_grid = grid.clone
      grid.each_cell do |val, x, y|
        new_grid[x, y] = rules.call(current: grid[x, y], neighbors: grid.neighbors(x, y))
      end
      @grid = new_grid
    end
  end
end

