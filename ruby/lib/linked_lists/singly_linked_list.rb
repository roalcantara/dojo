# frozen_string_literal: true

# Singly linked list
#
# Each node contains the data we want to store,
# as well as a next pointer to the next node in the linked list.
# Singly linked lists support traversal in only one direction.
#
# source: https://codefights.com/interview-practice/topics/linked-lists/tutorial

module LinkedLists
  class SinglyLinkedList
    attr_accessor :value, :next

    def initialize(val)
      @value = val
      @next = nil
    end

    def self.build(values)
      values.reverse.inject(nil) do |memo, value|
        list = SinglyLinkedList.new(value)
        list.next = memo
        list
      end
    end
  end
end
