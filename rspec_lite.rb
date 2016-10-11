require_relative './example_group'

def describe(description, &block)
  ExampleGroup.new(description, block).evaluate!
end
