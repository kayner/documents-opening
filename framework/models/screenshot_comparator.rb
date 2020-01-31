# frozen_string_literal: true

# Class for control screenshot behavior
class Screenshot
  def initialize(path)
    @binary_img = ChunkyPNG::Image.from_file path
  end

  def compare_with(screenshot)
    diff = []
    @binary_img.height.times do |y|
      @binary_img.row(y).each_with_index do |pixel, x|
        diff << [x, y] unless pixel == screenshot[x, y]
      end
    end
    100 * diff.length.to_f / @binary_img.pixels.length
  end

  def different_map(scr)
    @binary_img.height.times do |y|
      @binary_img.row(y).each_with_index do |px, x|
        scr[x, y] = rgb(r(px) + r(scr[x, y]) - 2 * [r(px), r(scr[x, y])].min,
                        g(px) + g(scr[x, y]) - 2 * [g(px), g(scr[x, y])].min,
                        b(px) + b(scr[x, y]) - 2 * [b(px), b(scr[x, y])].min)
      end
    end
  end
end
