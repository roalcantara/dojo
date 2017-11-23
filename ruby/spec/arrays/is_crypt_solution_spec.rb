# frozen_string_literal: true

require 'spec_helper'
require 'arrays/is_crypt_solution'

# A cryptarithm is a mathematical puzzle for which the goal is to find
# the correspondence between letters and digits, such that the given arithmetic equation
# consisting of letters holds true when the letters are converted to digits.
#
# You have an array of strings crypt, the cryptarithm,
# and an an array containing the mapping of letters and digits, solution.
#
# The array crypt will contain three non-empty strings that follow the structure:
# [word1, word2, word3] which should be interpreted as the word1 + word2 = word3 cryptarithm.
#
# If crypt, when it is decoded by replacing all of the letters in the cryptarithm
# with digits using the mapping in solution, becomes a valid arithmetic equation
# containing no numbers with leading zeroes, the answer is true.
#
# If it does not become a valid arithmetic solution, the answer is false.

RSpec.describe Arrays::IsCryptSolution do
  let(:instance) { Arrays::IsCryptSolution.new }

  describe '#valid_arithmetic_equation_with_no_numbers_with_leading_zeroes?' do
    let(:crypt) { %w[SEND MORE MONEY] }
    let(:solution) do
      [
        %w[O 0],
        %w[M 1],
        %w[Y 2],
        %w[E 5],
        %w[N 6],
        %w[D 7],
        %w[R 8],
        %w[S 9]
      ]
    end

    subject! { instance.valid_arithmetic_equation_with_no_numbers_with_leading_zeroes?(crypt, solution) }

    it { is_expected.to be_truthy }

    context 'when decripting generate numbers with leading zeros' do
      let(:crypt) { %w[TEN TWO ONE] }
      let(:solution) do
        [
          %w[O 1],
          %w[T 0],
          %w[W 9],
          %w[E 5],
          %w[N 4]
        ]
      end

      it { is_expected.to be_falsey }
    end

    context 'when number is zero and does not has leading zeros' do
      let(:crypt) { %w[A A A] }
      let(:solution) { [%w[A 0]] }

      it { is_expected.to be_truthy }
    end
  end
end
