# frozen_string_literal: true

module Arrays
  class FirstNotRepeatingCharacter
    # My n00b solution.
    # def find(s)
    #   s.chars.each_with_object({}) do |value, memo|
    #     memo[value] = (memo[value] || 0) + 1
    #   end&.key(1) || '_'
    # end

    # The BEST solution!
    def find(s)
      s.chars.uniq.each { |c| return c if s.chars.count(c) == 1 }
      '_'
    end
  end
end
