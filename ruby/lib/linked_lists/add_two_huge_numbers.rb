# frozen_string_literal: true

# rubocop:disable Lint/Loop
module LinkedLists
  class AddTwoHugeNumbers
    def add(a, b)
      huge = extract_values(a).join.to_i + extract_values(b).join.to_i

      huge.to_s.reverse.scan(/.{1,4}/)
          .map { |v| v.reverse.to_i }.reverse
    end

    private

    def extract_values(l)
      values = []
      begin
        values << format('%.4i', l.value.to_s) unless l.nil?
      end while (l = l.next)
      values
    end
  end
end
