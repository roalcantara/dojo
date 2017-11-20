# frozen_string_literal: true

module Arrays
  class RotateImage
    # My n00b solution! :D
    # def rotate(a)
    #   a.map.with_index do |value, i|
    #     (value.size - 1).downto(0).map do |j|
    #       a[j][i]
    #     end
    #   end
    # end

    # The AWESOME solution!
    def rotate(a)
      a.transpose.map(&:reverse)
    end
  end
end
