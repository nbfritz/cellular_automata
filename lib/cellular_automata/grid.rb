module CellularAutomata
  class Grid
    attr_reader :rules, :width, :height, :empty

    def self.from_s(string)
      from_array(string.split("\n").map { |row| row.split("") })
    end

    def self.from_array(arr)
      new(width: arr.map(&:length).max, height: arr.length).tap do |grid|
        arr.each.with_index do |row, y|
          row.each.with_index do |value, x|
            grid[x, y] = value 
          end
        end
      end 
    end

    def initialize(width: 30, height: 20, empty: ".")
      @width, @height, @empty = width, height, empty
      @data = (0...height).map { [empty] * width }
    end

    def to_s
      @data.map { |row| row.join("") }.join("\n")
    end


    def [](x, y)
      return nil if (x < 0 || x >= width) || (y < 0 || y >= height)
      @data[y][x]
    end

    def []=(x, y, val)
      @data[y][x] = val
    end

    def neighbors(x, y)
      apply_transformation(x, y, [
        [-1, -1], [ 0, -1], [ 1, -1],
        [-1,  0],           [ 1,  0],
        [-1,  1], [ 0,  1], [ 1,  1]
      ])
    end

    def apply_transformation(origin_x, origin_y, transformation)
      transformation.map { |(x_offset, y_offset)| self[origin_x + x_offset, origin_y + y_offset] }
    end

    def each_cell
      return enum_for(:each_cell) unless block_given?

      @data.each.with_index do |row, y|
        row.each.with_index do |cell, x|
          yield(cell, x, y)
        end
      end
    end

    def overlay(origin_x, origin_y, other)
      other.each_cell do |val, offset_x, offset_y|
        self[origin_x + offset_x, origin_y + offset_y] = val
      end
    end

  private

    # required to prevent issues when cloning @data's sub-arrays.
    def initialize_copy(other)
      super
      @data = @data.map(&:clone)
    end
  end
end

