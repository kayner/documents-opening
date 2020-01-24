# frozen_string_literal: true

# Module for extending Appium functional
module AppiumExtension
  # @param [Selenium::WebDriver] driver, Instance of Appium::Driver for performing
  # @param [String] id, Id selector
  # @param [Integer] time, Time for searching elements
  def click(driver:, id:, time: 30)
    driver.wait_true(time) do
      driver.find_element(id: id).click
    end
  end

  # @param [Selenium::WebDriver] driver, Instance of Appium::Driver for performing
  # @param [String] id, Id selector
  # @param [Integer] time, Time for searching elements
  def element(driver:, id:, time: 30)
    time.times do
      target = driver.find_elements(id: id)
      return target if target.count.positive?

      sleep 1
    end
    nil
  end

  # @param [Selenium::WebDriver] driver, Instance of Appium::Driver for performing
  # @param [String] id, Id selector
  # @param [Integer] time, Time for searching elements
  # @param [String] data, Data for sending to fill
  def fill(driver:, id:, data:, time: 30)
    driver.wait_true(time) do
      driver.find_element(id: id).send_keys data
    end
  end

  # @param [Selenium::WebDriver] driver, Instance of Appium::Driver for performing
  # @param [String] id, Id selector
  # @param [Integer] time, Time for searching elements
  def elements(driver:, id:, time: 30)
    driver.wait_true(time) do
      driver.find_elements(id: id)
    end
  end

  # @param [Selenium::WebDriver] driver, Instance of Appium::Driver for performing
  def close_keyboard(driver:)
    driver.hide_keyboard if driver.is_keyboard_shown
  end

  # @param [Selenium::WebDriver] driver, Instance of Appium::Driver for performing
  def hardback(driver:)
    driver.press_keycode 4
  end
end
