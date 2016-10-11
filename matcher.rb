require_relative 'test_result'

class Matcher

  def initialize(value_to_match, &block)
    @block = block;
    @value_to_match = value_to_match
  end

  def run(subject)
    # return TestResult.new(result, subject, value_to_match)
    result = block.call(subject, value_to_match)
  end

  private
  attr_reader :value_to_match, :block

end
