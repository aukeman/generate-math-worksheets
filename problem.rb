require_relative 'override_equality'

class Problem

  include OverrideEquality

  attr_reader :terms, :operation

  def initialize( terms = [0,0], operation = '+' )
    @terms=terms
    @operation=operation
  end

  def to_json
    { terms: terms, operation: operation }.to_json
  end

end
