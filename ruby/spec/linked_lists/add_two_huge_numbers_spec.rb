# frozen_string_literal: true

require 'spec_helper'
require 'linked_lists/singly_linked_list'
require 'linked_lists/add_two_huge_numbers'

# You're given 2 huge integers represented by linked lists.
#
# Each linked list element is a number from 0 to 9999
# that represents a number with exactly 4 digits.
#
# The represented number might have leading zeros.
#
# Your task is to add up these huge integers
# and return the result in the same format.

RSpec.describe LinkedLists::AddTwoHugeNumbers do
  let(:instance) { LinkedLists::AddTwoHugeNumbers.new }

  describe '#add' do
    let(:a_values) { [9876, 5432, 1999] }
    let(:b_values) { [1, 8001] }
    let(:a) { LinkedLists::SinglyLinkedList.build a_values }
    let(:b) { LinkedLists::SinglyLinkedList.build b_values }

    subject! { instance.add a, b }

    it { is_expected.to eq [9876, 5434, 0] }

    context 'when less than 3 digits are given for each value' do
      let(:a_values) { [123, 4, 5] }
      let(:b_values) { [100, 100, 100] }

      it { is_expected.to eq [223, 104, 105] }
    end
  end
end
