# frozen_string_literal: true

# rubocop:disable Lint/Loop
module LinkedLists
  class IsListPalindrome
    def palindrome?(l)
      values = []

      begin
        values << l&.value
      end while (l = l&.next)

      values == values.reverse
    end
  end
end
