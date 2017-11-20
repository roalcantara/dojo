# frozen_string_literal: true

require 'spec_helper'
require 'arrays/rotate_image'

# You are given an n x n 2D matrix that represents an image.
# Rotate the image by 90 degrees (clockwise).

RSpec.describe Arrays::RotateImage do
  let(:instance) { Arrays::RotateImage.new }

  describe '#rotate' do
    let(:a) do
      [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ]
    end

    subject! { instance.rotate(a) }

    it 'rotates the image clockwise' do
      is_expected.to eq [
        [7, 4, 1],
        [8, 5, 2],
        [9, 6, 3]
      ]
    end
  end
end
