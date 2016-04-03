maximum_top=25
maximum_bottom=9
spaces_per_column=[maximum_top, maximum_bottom].max.to_s.length+2 
max_numbers_to_add=4

addition=true
subtraction=true
greater_on_top=true

number_of_columns=2
number_of_rows=2

operations=[]
operations << '+' if addition
operations << '-' if subtraction

number_of_rows.times do

  row=[]
  number_of_columns.times do

    top=rand(maximum_top)

    if !greater_on_top || (maximum_bottom < top)
      bottom=rand(maximum_bottom)
    else
      bottom=rand(top)
    end

    operation = operations.sample

    row << { 
      top: sprintf( "  %#{spaces_per_column-2}d", top),
      bottom: sprintf( " #{operation}%#{spaces_per_column-2}d", bottom) }
  end

  # print the top numbers in the columns
  row.each do |column|
    $stdout.write( column[:top] )
  end
  puts
  row.each do |column|
    $stdout.write( column[:bottom] )
  end
  puts
  row.each do |column|
    $stdout.write( " #{'-' * (spaces_per_column-1)}" )
  end

  puts
  puts
  puts

end





