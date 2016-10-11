class Expectation

  def initialize(subject)
    @subject = subject
  end

  def to(matcher)
    matcher.run(subject)
  end

  def not_to(matcher)
    matcher.run(subject)
  end

  private
  attr_reader :subject, :result

end
