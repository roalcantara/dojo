# frozen_string_literal: true

module Arrays
  class FirstDuplicated
    def find(a)
      a.each_with_index.inject({}) do |memo, (value, index)|
        break value if memo[value]
        break -1 if index == a.length - 1
        memo.merge!(value => 1)
      end
    end
  end
end
