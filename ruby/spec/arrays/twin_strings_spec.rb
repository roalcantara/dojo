# frozen_string_literal: true

require 'spec_helper'
require 'arrays/twin_strings'

# String Swap
#
# Two strings, a and b, are said to be twins only if they can be made equivalent by performing some number of
# operations on one or both strings. There are two possible operations:
#
# SwapEven: Swap a character at an even-numbered index with a character at another even-numbered index.
#
# SwapOdd: Swap a character at an odd-numbered index with a character at another odd-numbered index.
#
# For example, a = "abcd" and b = "cdab" are twins because we can make them equivalent by performing operations.
# Alternatively, a = "abcd" and b = "bcda" are not twins (operations don't move characters between odd and even indices)
# and neither are a = "abc" and b = "ab" (no amount of operations will insert a 'c' into string b).
#
# Create a twins function. It has two parameters:
#
# An array of n strings named a.
# An array of n strings named b.
# The function must return an array of strings where each index i (0 <= i < n)
# contains the string Yes if ai and bi are twins or the string No if they are not.

RSpec.describe Arrays::TwinStrings do
  let(:instance) { Arrays::TwinStrings.new }

  describe '#swap_even_indexes_characters_from' do
    let(:values) { 'abcd' }

    subject! { instance.swap_even_indexes_characters_from(values.split('')) }

    it 'swaps a character at an even-numbered index with a character at another even-numbered index' do
      is_expected.to eq 'cbad'
    end
  end

  describe '#swap_odd_indexes_characters_from' do
    let(:values) { 'abcd' }

    subject! { instance.swap_odd_indexes_characters_from(values.split('')) }

    it 'swaps a character at an odd-numbered index with a character at another odd-numbered index' do
      is_expected.to eq 'adcb'
    end
  end

  describe '#collect_swapped_strings_of' do
    let(:values) { 'abcd' }

    subject! { instance.collect_swapped_strings_of(values) }

    it 'returns all swapped strings possible' do
      is_expected.to eq %w[cbad cdab]
    end
  end

  describe '#twins?' do
    let(:a) { 'abcd' }
    let(:b) { 'cdab' }

    subject! { instance.twins?(a, b) }

    context 'when values are equivalent by performing operations' do
      it { is_expected.to be_truthy }
    end

    context 'when operations do not move characters between odd and even indices' do
      let(:a) { 'abcd' }
      let(:b) { 'bcda' }

      it { is_expected.to be_falsey }
    end

    context 'when the first value is Nil' do
      let(:a) { nil }

      it { is_expected.to be_falsey }
    end

    context 'when the second value is Nil' do
      let(:b) { nil }

      it { is_expected.to be_falsey }
    end
  end

  describe '#are_twins?' do
    context 'when two arrays of strings are given' do
      let(:a) { %w[cdab dcba] }
      let(:b) { %w[abcd abcd] }

      subject! { instance.are_twins?(a, b) }

      context 'with twins values at the same index' do
        it 'returns an array of strings containing `Yes` at the index of the twins values' do
          is_expected.to eq %w[Yes No]
        end
      end

      context 'with no twins values at the same index' do
        let(:a) { ['abcd'] }
        let(:b) { ['bcda'] }

        it 'returns an array of strings containing `No` at the index of the non-twins values' do
          is_expected.to eq ['No']
        end
      end

      context 'with one array larger than the other' do
        let(:a) { %w[abcd abcd] }
        let(:b) { %w[cdab] }

        it 'returns an array of strings containing `No` at the index of the null values' do
          is_expected.to eq %w[Yes No]
        end
      end

      context 'with some items of the arrays with different lengths' do
        let(:a) { %w[abcd] }
        let(:b) { %w[cd] }

        it 'returns an array of strings containing `No` at the index of the different lengths values' do
          is_expected.to eq %w[No]
        end
      end
    end
  end
end
