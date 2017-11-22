# frozen_string_literal: true

require 'spec_helper'
require 'arrays/sudoku2'
require 'matrix'

# Sudoku is a number-placement puzzle.
#
# The objective is to fill a 9x9 grid with numbers in such a way that
# each column, each row, and each of the nine 3x3 sub-grids that compose
# the grid all contain all of the numbers from 1 to 9 one time.
#
# Implement an algorithm that will check whether the given grid of numbers
# represents a valid Sudoku puzzle according to the layout rules described above.
#
# Note that the puzzle represented by grid does not have to be solvable.

RSpec.describe Arrays::Sudoku2 do
  let(:instance) { Arrays::Sudoku2.new }

  describe '#subgrids' do
    let(:grid) do
      [
        ['.', '.', '.', '1', '4', '.', '.', '2', '.'],
        ['.', '.', '6', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '1', '.', '.', '.', '.', '.', '.'],
        ['.', '6', '7', '.', '.', '.', '.', '.', '9'],
        ['.', '.', '.', '.', '.', '.', '8', '1', '.'],
        ['.', '3', '.', '.', '.', '.', '.', '.', '6'],
        ['.', '.', '.', '.', '.', '7', '.', '.', '.'],
        ['.', '.', '.', '5', '.', '.', '.', '7', '.']
      ]
    end

    subject! { instance.subgrids grid }

    it 'returns all 9 3x3 subgrids ' do
      is_expected.to eq [
        Matrix[
          ['.', '.', '.'],
          ['.', '.', '6'],
          ['.', '.', '.']
        ],
        Matrix[
          ['1', '4', '.'],
          ['.', '.', '.'],
          ['.', '.', '.']
        ],
        Matrix[
          ['.', '2', '.'],
          ['.', '.', '.'],
          ['.', '.', '.']
        ],
        Matrix[
          ['.', '.', '1'],
          ['.', '6', '7'],
          ['.', '.', '.']
        ],
        Matrix[
          ['.', '.', '.'],
          ['.', '.', '.'],
          ['.', '.', '.']
        ],
        Matrix[
          ['.', '.', '.'],
          ['.', '.', '9'],
          ['8', '1', '.']
        ],
        Matrix[
          ['.', '3', '.'],
          ['.', '.', '.'],
          ['.', '.', '.']
        ],
        Matrix[
          ['.', '.', '.'],
          ['.', '.', '7'],
          ['5', '.', '.']
        ],
        Matrix[
          ['.', '.', '6'],
          ['.', '.', '.'],
          ['.', '7', '.']
        ]
      ]
    end
  end

  describe '#valid?' do
    let(:grid) do
      [
        ['.', '.', '.', '1', '4', '.', '.', '2', '.'],
        ['.', '.', '6', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '1', '.', '.', '.', '.', '.', '.'],
        ['.', '6', '7', '.', '.', '.', '.', '.', '9'],
        ['.', '.', '.', '.', '.', '.', '8', '1', '.'],
        ['.', '3', '.', '.', '.', '.', '.', '.', '6'],
        ['.', '.', '.', '.', '.', '7', '.', '.', '.'],
        ['.', '.', '.', '5', '.', '.', '.', '7', '.']
      ]
    end

    subject! { instance.valid? grid }

    context 'when the grid has been filled correctly' do
      it { is_expected.to be_truthy }
    end

    context 'when the grid has not been filled correctly' do
      let(:grid) do
        [
          ['.', '.', '.', '.', '2', '.', '.', '9', '.'],
          ['.', '.', '.', '.', '6', '.', '.', '.', '.'],
          ['7', '1', '.', '.', '7', '5', '.', '.', '.'],
          ['.', '7', '.', '.', '.', '.', '.', '.', '.'],
          ['.', '.', '.', '.', '8', '3', '.', '.', '.'],
          ['.', '.', '8', '.', '.', '7', '.', '6', '.'],
          ['.', '.', '.', '.', '.', '2', '.', '.', '.'],
          ['.', '1', '.', '2', '.', '.', '.', '.', '.'],
          ['.', '2', '.', '.', '3', '.', '.', '.', '.']
        ]
      end

      it { is_expected.to be_falsey }
    end

    context 'when the grid has one row without a number' do
      let(:grid) do
        [
          ['.', '4', '.', '.', '.', '.', '.', '.', '.'],
          ['.', '.', '4', '.', '.', '.', '.', '.', '.'],
          ['.', '.', '.', '1', '.', '.', '7', '.', '.'],
          ['.', '.', '.', '.', '.', '.', '.', '.', '.'],
          ['.', '.', '.', '3', '.', '.', '.', '6', '.'],
          ['.', '.', '.', '.', '.', '6', '.', '9', '.'],
          ['.', '.', '.', '.', '1', '.', '.', '.', '.'],
          ['.', '.', '.', '.', '.', '.', '2', '.', '.'],
          ['.', '.', '.', '8', '.', '.', '.', '.', '.']
        ]
      end

      it { is_expected.to be_falsey }
    end
  end
end
