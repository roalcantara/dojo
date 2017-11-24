# frozen_string_literal: true

require 'spec_helper'
require 'linked_lists/singly_linked_list'
require 'linked_lists/remove_k_from_list'

# Given a singly linked list of integers l and an integer k
# remove all elements from list l that have a value equal to k.

RSpec.describe LinkedLists::RemoveKFromList do
  let(:instance) { LinkedLists::RemoveKFromList.new }

  describe '#remove' do
    let(:values) { [3, 1, 2, 3, 4, 5] }
    let(:l) { LinkedLists::SinglyLinkedList.build values }
    let(:k) { 3 }

    subject! { instance.remove l, k }

    it { is_expected.to eq [1, 2, 4, 5] }

    context 'when list is empty' do
      let(:values) { [] }
      let(:k) { -1000 }

      it { is_expected.to eq [] }
    end
  end
end
