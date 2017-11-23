# frozen_string_literal: true

module Arrays
  class IsCryptSolution
    def valid_arithmetic_equation_with_no_numbers_with_leading_zeroes?(crypt, solution)
      solution_hash = solution.to_h

      decrypted = crypt.map do |encrypted|
        encrypted.chars.inject('') do |memo, char|
          return false if memo == '0'
          memo + solution_hash[char]
        end.to_i
      end

      decrypted[0] + decrypted[1] == decrypted[2]
    end
  end
end
