# frozen_string_literal: true

module Arrays
  class TwinStrings
    def swap_even_indexes_characters_from(values)
      swap_indexes_characters_at(:evens, values)
    end

    def swap_odd_indexes_characters_from(values)
      swap_indexes_characters_at(:odds, values)
    end

    def collect_swapped_strings_of(values)
      array = values&.split('')
      [
        swap_even_indexes_characters_from(array),
        swap_odd_indexes_characters_from(array)
      ]
    end

    def twins?(a, b)
      collect_swapped_strings_of(a).include?(b) ||
        collect_swapped_strings_of(b).include?(a)
    end

    def are_twins?(a, b)
      a.map.with_index do |value, index|
        twins?(value, b[index]) ? 'Yes' : 'No'
      end
    end

    private

    def swap?(type, index)
      type == :evens ? index.even? : index.odd?
    end

    def swap_indexes_characters_at(type, values)
      values&.each_with_index do |_, index|
        if swap?(type, index) && values[index + 2]
          values[index], values[index + 2] = values[index + 2], values[index]
        end
      end&.join
    end
  end
end
