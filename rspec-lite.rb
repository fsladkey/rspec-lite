require 'colorize'

class ExampleGroup
  def initialize(description, block)
    @description = description
    @block = block
    @indent = 0
  end

  def evaluate!
    puts description
    instance_eval(&block)
  end

  def it(description, &block)
    result = instance_eval(&block)
    print ("  " * indent) + "it #{description}"
    puts result ? " - #{"passed".colorize(:green)}" : " - #{"failed".colorize(:red)}"
  end

  def describe(description, &block)
    @indent += 1
    puts ("  " * indent) + "#{description}"
    @indent += 1
    instance_eval(&block)
    @indent -= 2
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

  private
  attr_reader :description, :block, :tests, :expectations, :indent

end

class Expectation

  def initialize(subject)
    @subject = subject
  end

  def to(matcher)
    matcher.run(subject)
  end

  def not_to(matcher)
    !matcher.run(subject)
  end

  private
  attr_reader :subject

end

class Matcher

  def initialize(value_to_match, &block)
    @block = block;
    @value_to_match = value_to_match
  end

  def run(subject)
    block.call(subject, value_to_match)
  end

  private
  attr_reader :value_to_match, :block

end

def describe(description, &block)
  ExampleGroup.new(description, block).evaluate!
end

describe "math" do

  describe "plus" do

    it "works" do
      expect(1 + 1).to eq 2
    end

    it "makes sense" do
      expect(2 + 2).not_to eq 4
    end

  end

  describe "minus" do
    it "works" do
      expect(5 - 1).to eq 4
    end

    it "makes sense" do
      expect(1 - 1).not_to eq 0
    end
  end

end
