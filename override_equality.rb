module OverrideEquality

  def ==(other)
    self.class == other.class && self.state == other.state
  end

  alias_method :eql?, :==

  def hash
    state.hash
  end
    
  protected 

  def state
    self.instance_variables.map {|v| self.instance_variable_get v}
  end
       
end
