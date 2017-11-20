# frozen_string_literal: true

require 'spec_helper'
require 'arrays/first_duplicated'

# Given an array a that contains only numbers in the range from 1 to a.length,
# find the first duplicate number for which the second occurrence has the minimal index.
# In other words, if there are more than 1 duplicated numbers, return the number for which
# the second occurrence has a smaller index than the second occurrence of the other number does.
# If there are no such elements, return -1.
#
# Example
#
# For a = [2, 3, 3, 1, 5, 2], the output should be
# firstDuplicate(a) = 3.
#
# There are 2 duplicates: numbers 2 and 3.
# The second occurrence of 3 has a smaller index than than second occurrence of 2 does, so the answer is 3.
#
# For a = [2, 4, 3, 5, 1], the output should be
# firstDuplicate(a) = -1.

RSpec.describe Arrays::FirstDuplicated do
  let(:instance) { Arrays::FirstDuplicated.new }

  describe '#find' do
    let(:a) { [2, 3, 3, 1, 5, 2] }

    subject! { instance.find(a) }

    context 'when there are duplicates occurences' do
      it { is_expected.to eq 3 }
    end

    context 'when there are no duplicates occurences' do
      let(:a) { [2, 4, 3, 5, 1] }

      it { is_expected.to eq(-1) }
    end

    context 'when there are no duplicates occurences' do
      let(:a) { [1, 1, 2, 2, 1] }

      it { is_expected.to eq 1 }
    end

    context 'when there is just one element' do
      let(:a) { [1] }

      it { is_expected.to eq(-1) }
    end

    context 'when there is just one element' do
      let(:a) { [8, 4, 6, 2, 6, 4, 7, 9, 5, 8] }

      it { is_expected.to eq 6 }
    end
  end
end
