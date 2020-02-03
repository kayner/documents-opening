# frozen_string_literal: true

# Class for control screenshot behavior
class Screenshot
  attr_reader :binary_img
  include ChunkyPNG::Color

  # @param [String] path
  # @return [Screenshot] instance
  def initialize(path)
    @binary_img = ChunkyPNG::Image.from_file path
  end

  # @param [Screenshot] screenshot
  # @return [Integer] different between 2 screenshots in percents
  def compare_with(screenshot)
    diff = []
    @binary_img.height.times do |y|
      @binary_img.row(y).each_with_index do |pixel, x|
        diff << [x, y] unless pixel == screenshot.binary_img[x, y]
      end
    end
    100 * diff.length.to_f / @binary_img.pixels.length
  end

  # @param [Screenshot] scr, Screenshot
  # @param [String] name, Different map name
  def different_map(scr, name)
    scr = scr.binary_img
    @binary_img.height.times do |y|
      @binary_img.row(y).each_with_index do |px, x|
        scr[x, y] = rgb(r(px) + r(scr[x, y]) - 2 * [r(px), r(scr[x, y])].min,
                        g(px) + g(scr[x, y]) - 2 * [g(px), g(scr[x, y])].min,
                        b(px) + b(scr[x, y]) - 2 * [b(px), b(scr[x, y])].min)
      end
    end
    scr.save(name)
  end
end
