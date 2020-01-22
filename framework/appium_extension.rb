# frozen_string_literal: true

# Class for extending Appium functional
module AppiumExtension
  def click(driver:, id:, time: 30)
    driver.wait_true(time) do
      driver.find_element(id: id).click
    end
  end

  def element(driver:, id:, time: 30)
    time.times do
      target = driver.find_elements(id: id)
      return target if target.count.positive?

      sleep 1
    end
    nil
  end

  def fill(driver:, id:, data:, time: 30)
    driver.wait_true(time) do
      driver.find_element(id: id).send_keys data
    end
  end

  def elements(driver:, id:, time: 30)
    driver.wait_true(time) do
      driver.find_elements(id: id)
    end
  end

  def close_keyboard(driver:)
    driver.hide_keyboard if driver.is_keyboard_shown
  end

  def hardback(driver:)
    driver.press_keycode 4
  end
end
