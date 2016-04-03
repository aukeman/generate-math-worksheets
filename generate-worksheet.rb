maximum_top=10
maximum_bottom=9
spaces_between_columns=5
lines_between_rows=3
spaces_per_column=[maximum_top, maximum_bottom].max.to_s.length+spaces_between_columns 

max_terms_to_add=2
addition=true
subtraction=false
greater_on_top=true

maximum_lines_per_page=75

number_of_columns=10
number_of_rows=100

operations=[]
operations << '+' if addition
operations << '-' if subtraction


lines_left_before_page_break=maximum_lines_per_page
number_of_rows.times do

  row=[]
  max_number_of_terms_in_row=0
  number_of_columns.times do

    top = rand(maximum_top+1)
    terms=[ sprintf( "#{" "*spaces_between_columns}%#{spaces_per_column-spaces_between_columns}d", top) ]

    operation = operations.sample
    number_of_terms_left=(operation == '-' ? 2 : rand(max_terms_to_add)+1)-1
    if number_of_terms_left < 1
      number_of_terms_left = 1
    end

    number_of_terms_left.times do |idx|
      if !greater_on_top || (maximum_bottom < top)
        next_term=rand(maximum_bottom+1)
      else
        next_term=rand(top+1)
      end
      op_column=(idx==(number_of_terms_left-1) ? operation : " ")
      terms << sprintf( "#{" "*(spaces_between_columns-1)}#{op_column}%#{spaces_per_column-spaces_between_columns}d", next_term)
    end

    if max_number_of_terms_in_row < terms.length 
      max_number_of_terms_in_row = terms.length
    end

    row << { terms: terms }
  end

  row.each do |column|
    while column[:terms].length < max_number_of_terms_in_row
      column[:terms].unshift(" "*spaces_per_column)
    end
  end

  number_of_lines_for_row = (max_number_of_terms_in_row+
                             lines_between_rows+
                             1)

  lines_left_before_page_break -= number_of_lines_for_row

  if lines_left_before_page_break < 0
    $stdout.write("\f")
    lines_left_before_page_break=(maximum_lines_per_page-number_of_lines_for_row)
  end

  max_number_of_terms_in_row.times do |idx|
    row.each do |column|
      $stdout.write( column[:terms].shift )
    end
    puts
  end
  row.each do |column|
    $stdout.write( "#{" "*(spaces_between_columns-1)}#{'-'*(spaces_per_column-(spaces_between_columns-1))}" )
  end

  lines_between_rows.times { $stdout.puts }

end





