module CellularAutomata
  module Rules
    module Life
      def self.next(current, neighbors)
        lnc = neighbors.compact.select { |c| c == "O" }.count
        if [3].include?(lnc) || (current == "O" && [2, 3].include?(lnc))
          "O"
        else
          "."
        end
      end
    end
  end
end


