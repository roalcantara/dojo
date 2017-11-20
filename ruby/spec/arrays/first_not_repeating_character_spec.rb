# frozen_string_literal: true

require 'spec_helper'
require 'arrays/first_not_repeating_character'

# Given a string s, find and return the first instance of a non-repeating character in it.
# If there is no such character, return '_'.
#
# Example
#
# For s = "abacabad", the output should be
# firstNotRepeatingCharacter(s) = 'c'.
#
# There are 2 non-repeating characters in the string: 'c' and 'd'.
# Return c since it appears in the string first.
#
# For s = "abacabaabacaba", the output should be
# firstNotRepeatingCharacter(s) = '_'.
#
# There are no characters in this string that do not repeat.

RSpec.describe Arrays::FirstNotRepeatingCharacter do
  let(:instance) { Arrays::FirstNotRepeatingCharacter.new }

  describe '#find' do
    let(:s) { 'abacabad' }

    subject! { instance.find(s) }

    context 'when there are two non-repeating character' do
      it 'returns the 1st occurence' do
        is_expected.to eq 'c'
      end
    end

    context 'when there are no non-repeating characters' do
      let(:s) { 'abacabaabacaba' }

      it { is_expected.to eq '_' }
    end

    context 'when there are only repeaded characters' do
      let(:s) { 'zzz' }

      it { is_expected.to eq '_' }
    end

    context 'when there are just one non-repeating characters' do
      let(:s) { 'bcccccccccccccyb' }

      it { is_expected.to eq 'y' }
    end
  end
end
