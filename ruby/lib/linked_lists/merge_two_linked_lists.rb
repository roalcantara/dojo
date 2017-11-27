# frozen_string_literal: true

# rubocop:disable Lint/Loop
module LinkedLists
  class MergeTwoLinkedLists
    def extract(l)
      values = []

      begin
        values << l.value unless l.nil?
      end while(l = l&.next)

      values
    end

    def merge(l1, l2)
      values1 = extract(l1)
      values2 = extract(l2)

      (values1 + values2).sort
    end
  end
end
