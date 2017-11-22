# frozen_string_literal: true

require 'matrix'

module Arrays
  class Sudoku2
    def valid?(grid)
      find_duplicated_numbers(grid).size.zero? &&
        find_duplicated_numbers(grid.transpose).size.zero? &&
        find_duplicated_numbers(subgrids(grid)).size.zero?
    end

    def subgrids(grid)
      matrix = Matrix.rows(grid)
      (0..8).step(3).flat_map do |i|
        (0..8).step(3).map do |j|
          matrix.minor(i, 3, j, 3)
        end
      end
    end

    private

    def find_duplicated_numbers(array)
      array.flat_map do |row|
        row.to_a.flatten.uniq.find_all { |e| e.match?(/^(\d)+$/) && row.count(e) > 1 }
      end
    end
  end
end
