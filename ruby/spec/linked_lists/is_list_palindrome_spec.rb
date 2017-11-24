# frozen_string_literal: true

require 'spec_helper'
require 'linked_lists/singly_linked_list'
require 'linked_lists/is_list_palindrome'

# A palindrome is a string that reads
# the same left-to-right and right-to-left.
#
# Given a singly linked list of integers,
# determine whether or not it's a palindrome.

RSpec.describe LinkedLists::IsListPalindrome do
  let(:instance) { LinkedLists::IsListPalindrome.new }

  describe '#palindrome' do
    let(:values) { [0, 1, 0] }
    let(:l) { LinkedLists::SinglyLinkedList.build values }

    subject! { instance.palindrome? l }

    it { is_expected.to be_truthy }

    context 'when list is empty' do
      let(:values) { [] }

      it { is_expected.to be_truthy }
    end

    context 'when list are not the same left-to-right and right-to-left' do
      let(:values) { [1, 2, 2, 3] }

      it { is_expected.to be_falsey }
    end

    context '' do
      let(:values) { [1, 1_000_000_000, -1_000_000_000, -1_000_000_000, 1_000_000_000, 1] }

      it { is_expected.to be_truthy }
    end
  end
end
