# frozen_string_literal: true

module AppiumExtender
  DEFAULT_TTS = 30

  def click(id:, time: DEFAULT_TTS)
    wait_true(time) do
      return if find_element(id: id).click
    end
  end

  def fill(id:, data:, time: DEFAULT_TTS)
    wait_true(time) do
      return if find_element(id: id).send_keys data
    end
  end

  def element_exist?(id:, time: DEFAULT_TTS)
    time.times do
      return true if find_elements(id: id).count.positive?

      sleep 1
    end
    false
  end

  def hardback
    press_keycode 4
  end
end
