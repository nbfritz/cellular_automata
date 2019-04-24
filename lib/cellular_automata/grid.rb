module CellularAutomata
  class Grid
    attr_reader :seed, :rules, :width, :height, :data

    def initialize(seed:, rules:, width: 30, height: 20)
      @seed, @rules, @width, @height = seed.strip, rules, width, height
      @data = (0...width).map { [''] * height }
      plant_seed!
    end

    def next
      height.times.with_object([]) do |y, new_data|
        new_data << width.times.with_object("") do |x, row|
          row << rules.next(self[x, y], neighbors(x, y))
        end
      end.join("\n")
    end

    def [](x, y)
      return nil if x >= width || y < 0 || y >= height
      @data[y][x]
    end

    def neighbors(x, y)
      [
        [-1, -1], [ 0, -1], [ 1, -1],
        [-1,  0],           [ 1,  0],
        [-1,  1], [ 0,  1], [ 1,  1]
      ].map { |(x_offset, y_offset)| self[x + x_offset, y + y_offset] }
    end

  private

    def plant_seed!
      seed.split("\n").each.with_index do |row, y|
        row.each_char.with_index do |char, x|
          @data[y][x] = char
        end
      end
    end
  end
end

