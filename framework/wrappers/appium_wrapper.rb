# frozen_string_literal: true

# Module for extending Appium functional
module AppiumWrapper
  DEFAULT_TIME = 30

  # @param [Selenium::WebDriver] driver, Instance of Appium::Driver
  # @param [String] id, Id selector
  # @param [Integer] time, Time for searching elements
  def click(driver:, id:, time: DEFAULT_TIME)
    driver.wait_true(time) do
      driver.find_element(id: id).click
    end
  end

  # @param [Selenium::WebDriver] driver, Instance of Appium::Driver
  # @param [String] id, Id selector
  # @param [Integer] time, Time for searching elements
  def element(driver:, id:, time: DEFAULT_TIME)
    time.times do
      target = driver.find_elements(id: id)
      return target if target.count.positive?

      sleep 1
    end
    nil
  end

  # @param [Selenium::WebDriver] driver, Instance of Appium::Driver
  # @param [String] id, Id selector
  # @param [Integer] time, Time for searching elements
  # @param [String] data, Data for sending to fill
  def fill(driver:, id:, data:, time: DEFAULT_TIME)
    driver.wait_true(time) do
      driver.find_element(id: id).send_keys data
    end
  end

  # @param [Selenium::WebDriver] driver, Instance of Appium::Driver
  # @param [String] id, Id selector
  # @param [Integer] time, Time for searching elements
  def elements(driver:, id:, time: DEFAULT_TIME)
    driver.wait_true(time) do
      driver.find_elements(id: id)
    end
  end

  # @param [Selenium::WebDriver] driver, Instance of Appium::Driver
  def close_keyboard(driver:)
    driver.hide_keyboard if driver.is_keyboard_shown
  end

  # @param [Selenium::WebDriver] driver, Instance of Appium::Driver
  def hardback(driver:)
    driver.press_keycode 4
  end

  # @param [Selenium::WebDriver] driver, Instance of Appium::Driver
  # @param [String] id, Id selector
  # @param [Integer] time, Time for searching elements
  # @return [Boolean] element existing status
  def element_exist?(driver:, id:, time: DEFAULT_TIME)
    time.times do
      return true if driver.find_elements(id: id).count.positive?

      sleep 1
    end
    false
  end
end
