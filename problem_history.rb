class ProblemHistory

  def initialize(max_length=10)
    @history=[]
    @max_length=max_length
  end

  def has? problem
    @history.any? {|historical| historical == problem}
  end

  def ago problem
    @history.find_index(problem)
  end

  def add problem
    @history=@history.unshift(problem)[0..@max_length-1]
  end

end
