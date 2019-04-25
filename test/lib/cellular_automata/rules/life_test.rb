require "test_helper"

module CellularAutomata
  module Rules
    class LifeTest < Minitest::Test
      def test_initialization
        life = Life.new(current: Life::ALIVE, neighbors: build_neighbors(dead: 8))
        assert_equal(Life::ALIVE, life.current)
        assert_equal(build_neighbors(dead: 8), life.neighbors)
      end

      def test_underpopulation_death
        life = Life.new(current: Life::ALIVE, neighbors: build_neighbors(living: 1, dead: 7))
        assert_equal(Life::DEAD, life.call)
      end

      def test_overpopulation_death
        life = Life.new(current: Life::ALIVE, neighbors: build_neighbors(living: 4, dead: 4))
        assert_equal(Life::DEAD, life.call)
      end

      def test_survival
        life = Life.new(current: Life::ALIVE, neighbors: build_neighbors(living: 2, dead: 6))
        assert_equal(Life::ALIVE, life.call)
      end

      def test_birth
        life = Life.new(current: Life::DEAD, neighbors: build_neighbors(living: 3, dead: 5))
        assert_equal(Life::ALIVE, life.call)
      end

    private

      def build_neighbors(living: 0, dead: 0)
        [Life::ALIVE] * living + [Life::DEAD] * dead
      end
    end
  end
end

