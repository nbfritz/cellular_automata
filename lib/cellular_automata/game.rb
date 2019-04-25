module CellularAutomata
  class Game
    attr_reader :rules, :grid

    def initialize(rules:, grid:)
      @rules, @grid = rules, grid
    end

    def next
      new_data = grid.height.times.with_object([]) do |y, new_data|
        new_data << grid.width.times.with_object([]) do |x, row|
          row << rules.call(current: grid[x, y], neighbors: grid.neighbors(x, y))
        end
      end
      @grid = Grid.from_array(new_data)
    end

    def plant_seed(seed)
      seed.strip.split("\n").each.with_index do |row, y|
        row.each_char.with_index do |char, x|
          grid[x, y] = char
        end
      end
    end
  end
end

