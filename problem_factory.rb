require_relative 'problem'
require_relative 'problem_history'

class ProblemFactory
  
  attr_accessor :history
  attr_accessor :addition 
  attr_accessor :subtraction
  attr_accessor :maximum_term
  attr_accessor :minimum_term
  attr_accessor :greater_term_on_top
  attr_accessor :maximum_answer
  attr_accessor :minimum_answer
  attr_accessor :prng

  def initialize &block
    self.history=10
    self.addition=true
    self.subtraction=true
    self.maximum_term=10
    self.minimum_term=0
    self.greater_term_on_top=true
    self.maximum_answer=999
    self.minimum_answer=-999
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
      a,b=generate_term, generate_term
      b,a=a,b if greater_term_on_top && a < b
      op=@operations.sample(random: prng)
      problem=Problem.new([a,b], op) 
    end while constraints_unsatisfied_by problem 
    @problem_history.add problem
    problem
  end

  def constraints_unsatisfied_by problem
    (@problem_history.has?(problem) ||
     problem.answer < minimum_answer ||
     maximum_answer < problem.answer)
  end

  def generate_term
    prng.rand(maximum_term+1-minimum_term) + minimum_term
  end

end

