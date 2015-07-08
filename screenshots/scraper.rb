require "yaml"
# require "selenium-webdriver" installed: gem install selenium-webdriver
require "selenium-webdriver"

# monkey patch class Hash
class Hash
  def method_missing(method, *opts)
    m = method.to_s
    if self.has_key?(m)
      return self[m]
    elsif self.has_key?(m.to_sym)
      return self[m.to_sym]
    end
    super
  end
end

# define helpers
def ensure!
  raise "Assertion failed!" unless yield
end

def setup_driver config
  # expose config
  @config = config

  # setup profile
  profile = Selenium::WebDriver::Firefox::Profile.new

  # configure driver
  @driver = Selenium::WebDriver.for @config.browser.downcase.to_sym, profile: profile

  # configure window size
  @window = @driver.manage.window
  @window.move_to @config.position.x, @config.position.y
  @window.resize_to @config.dimension.width, @config.dimension.height

  # TODO: allow setup as https
  @uri_prefix = 'http'

  # setup default wait
  @wait = Selenium::WebDriver::Wait.new timeout: 30
end

def navigate_to url
  url = "http://#{url}" unless url =~ /^https?:\/\//
  @driver.navigate.to url
end

def url_start_with url
  @driver.current_url =~ /^https?:\/\/#{url}/
end

def url_match url
  @driver.current_url =~ /^https?:\/\/#{url}\/?$/
end

# define actions
## sign in
def sign_in username, password
  ensure! { url_match @config.urls.signin }

  username_field = @driver.find_element :id, 'username_id'
  username_field.send_keys username
  password_field = @driver.find_element :id, 'password_id'
  password_field.send_keys password
  password_field.submit

  @wait.until { url_start_with @config.urls.dashboard }
end

def go_buildflow
  link_buildflow = @driver.find_element :id, 'buildflow'
  ensure! { link_buildflow.displayed? }

  old_url = @driver.current_url
  link_buildflow.click

  @wait.until { old_url != @driver.current_url }
end

## take a screenshot
def screenshot_to name
  FileUtils.mkdir_p @config.screenshot.dir

  # wait page loaded
  sleep = Selenium::WebDriver::Wait.new timeout: @config.screenshot.wait
  sleep.until { false } rescue nil

  name = "#{name}.png" unless name.end_with? '.png'
  @driver.save_screenshot "#{@config.screenshot.dir}/#{name}"
end

##
def scrapper_start!
  # TODO: make this file from arguments
  config = YAML.load_file 'config.yml'

  setup_driver config
  puts "Use browser: #{@config.browser}."
  puts "Moved to: (#{@window.position.x}, #{@window.position.y})"
  puts "Resized to: (#{@window.size.width}, #{@window.size.height})"

  puts "Attampt to sign in for #{@config.user.username}"
  navigate_to @config.urls.signin
  sign_in @config.user.username, @config.user.password
  screenshot_to 'dashboard'
  puts "Dashboard screenshot saved!"

  puts "Navigate to buildflow"
  go_buildflow
  screenshot_to 'buildflow'
  puts "Dashboard screenshot saved!"
end

scrapper_start!
@driver.quit
