require_relative 'problem'
require_relative 'problem_history'

class ProblemFactory
  
  attr_accessor :history, :addition, :subtraction, :maximum, :maximum_on_top, :prng

  def initialize &block
    self.history=10
    self.addition=true
    self.subtraction=true
    self.maximum=10
    self.maximum_on_top=true
    self.prng=Random.new
    configure &block
  end

  def configure &block
    instance_eval(&block) if block_given?

    @problem_history=ProblemHistory.new(history)
    @operations = []
    @operations << '+' if addition
    @operations << '-' if subtraction
  end

  def build
    begin
      a,b=prng.rand(maximum), prng.rand(maximum)
      b,a=a,b if maximum_on_top && a < b
      op=@operations.sample(random: prng)
      problem=Problem.new([a,b], op) 
    end while @problem_history.has? problem
    @problem_history.add problem
    problem
  end
end

