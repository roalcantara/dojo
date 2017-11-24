# frozen_string_literal: true

module LinkedLists
  class RemoveKFromList
    def remove(l, k)
      values = []
      unless l.nil?
        loop do
          values << l.value if l.value != k
          break unless (l = l.next)
        end
      end
      values
    end
  end
end
