# frozen_string_literal: true

# rubocop:disable Lint/Loop
module LinkedLists
  class ReverseNodesInKGroups
    def extract_values(l)
      values = []
      begin
        values << l.value unless l.value.nil?
      end while(l = l&.next)
      values
    end

    def reverse(l, k)
      extracted = extract_values(l)
      extracted.map.with_index.with_object([]) do |(value, index), memo|
        memo << value
        if ((index + 1) % k).zero?
          values = memo.pop(k)
          memo << values.reverse!
        end
      end.flatten
    end
  end
end
