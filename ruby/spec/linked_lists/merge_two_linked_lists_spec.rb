# frozen_string_literal: true

require 'spec_helper'
require 'linked_lists/singly_linked_list'
require 'linked_lists/merge_two_linked_lists'

# Given two singly linked lists sorted in non-decreasing order,
# your task is to merge them.

# In other words, return a singly linked list, also sorted in non-decreasing order,
# that contains the elements from both original lists.

# Note: Your solution should have O(l1.length + l2.length) time complexity,
# since this is what you will be asked to accomplish in an interview.

RSpec.describe LinkedLists::MergeTwoLinkedLists do
  let(:instance) { LinkedLists::MergeTwoLinkedLists.new }

  describe '#remove' do
    let(:l1_values) { [1, 2, 3] }
    let(:l1) { LinkedLists::SinglyLinkedList.build l1_values }
    let(:l2_values) { [4, 5, 6] }
    let(:l2) { LinkedLists::SinglyLinkedList.build l2_values }

    subject! { instance.merge l1, l2 }

    it { is_expected.to eq [1, 2, 3, 4, 5, 6] }

    context 'when list is empty' do
      let(:l1_values) { [1, 1, 2, 4] }
      let(:l2_values) { [0, 3, 5] }

      it { is_expected.to eq [0, 1, 1, 2, 3, 4, 5] }
    end
  end
end
