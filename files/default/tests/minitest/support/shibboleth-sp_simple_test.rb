require "minitest/autorun"

describe_recipe "shibboleth-sp::simple" do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources
end
