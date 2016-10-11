require 'colorize'
require_relative './expectation'
require_relative './matcher'

class ExampleGroup
  def initialize(description, block)
    @description = description
    @block = block
    @indent = 0
    @tests = []
  end

  def describe(description, &block)
    @indent += 1
    puts ("  " * indent) + "#{description}"
    @indent += 1
    instance_eval(&block)
    @indent -= 2
  end

  def it(description, &block)
    result = instance_eval(&block)
    print ("  " * indent) + "it #{description}"
    puts result ? " - #{"passed".colorize(:green)}" : " - #{"failed".colorize(:red)}"
  end

  def expect(subject)
    Expectation.new(subject)
  end

  def be(value_to_match)
    Matcher.new(value_to_match) do |subject, value_to_match|
      subject.equal?(value_to_match)
    end
  end

  def eq(value_to_match)
    Matcher.new(value_to_match) do |subject, value_to_match|
      subject == value_to_match
    end
  end

  def evaluate!
    puts description
    instance_eval(&block)
  end

  private
  attr_reader :description, :block, :tests, :indent

end
