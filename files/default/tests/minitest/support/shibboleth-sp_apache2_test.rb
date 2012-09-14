require "minitest/autorun"

describe_recipe "shibboleth-sp::apache2" do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources
end
