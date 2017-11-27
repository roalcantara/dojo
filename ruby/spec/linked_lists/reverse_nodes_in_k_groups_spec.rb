# frozen_string_literal: true

require 'spec_helper'
require 'linked_lists/singly_linked_list'
require 'linked_lists/reverse_nodes_in_k_groups'

# Given a linked list l, reverse its nodes k at a time
# and return the modified list. k is a positive integer that is
# less than or equal to the length of l.
#
# If the number of nodes in the linked list is not a multiple of k,
# then the nodes that are left out at the end should remain as-is.
#
# You may not alter the values in the nodes - only
# the nodes themselves can be changed.

RSpec.describe LinkedLists::ReverseNodesInKGroups do
  let(:instance) { LinkedLists::ReverseNodesInKGroups.new }

  describe '#reverse' do
    let(:values) { [1, 2, 3, 4, 5] }
    let(:l) { LinkedLists::SinglyLinkedList.build values }
    let(:k) { 2 }

    subject! { instance.reverse l, k }

    it { is_expected.to eq [2, 1, 4, 3, 5] }

    context 'when the list can be reversed more than once' do
      let(:values) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11] }
      let(:k) { 3 }

      it { is_expected.to eq [3, 2, 1, 6, 5, 4, 9, 8, 7, 10, 11] }
    end

    context 'when list could not be reversed' do
      let(:values) { [1, 2, 3, 4, 5] }
      let(:k) { 1 }

      it { is_expected.to eq [1, 2, 3, 4, 5] }
    end

    context 'when list is empty' do
      let(:values) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12] }
      let(:k) { 4 }

      it { is_expected.to eq [4, 3, 2, 1, 8, 7, 6, 5, 12, 11, 10, 9] }
    end

    context '' do
      let(:values) { [1_000_000_000, -849_483_855, -1_000_000_000, 376_365_554, -847_904_832] }
      let(:k) { 4 }

      it { is_expected.to eq [376_365_554, -1_000_000_000, -849_483_855, 1_000_000_000, -847_904_832] }
    end
  end
end
