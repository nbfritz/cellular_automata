module CellularAutomata
  module Rules
    class Life
      DEAD = "."
      ALIVE = "O"

      attr_reader :current, :neighbors

      def self.call(current:, neighbors:)
        self.new(current: current, neighbors: neighbors).call
      end

      def initialize(current:, neighbors:)
        @current, @neighbors = current, neighbors
      end

      def call
        (birth? || survival?) ? ALIVE : DEAD
      end

    private

      def living_neighbor_count
        neighbors.compact.select { |c| c == ALIVE }.count
      end

      def birth?
        current == DEAD && [3].include?(living_neighbor_count)
      end

      def survival?
        current == ALIVE && [2, 3].include?(living_neighbor_count)
      end
    end
  end
end


