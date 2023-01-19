require 'set'
class SudokuValidator

  VALID_NUMBERS = (1..9).to_a.to_set

  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def validate
    valid?(string_to_array)
  end

  def valid?(puzzle)
    is_completed = !puzzle.flatten.include?(0)

    row_validations = puzzle.map { |row| valid_rows_columns_groups?(row) }
    col_validations = puzzle.transpose.map { |col| valid_rows_columns_groups?(col) }
    group_validations = puzzle.each_slice(3).flat_map do |rows|
      rows.transpose.each_slice(3).map { |block| valid_rows_columns_groups?(block.flatten) }
    end

    return 'Sudoku is invalid.' unless row_validations.all? && col_validations.all? && group_validations.all?
    return 'Sudoku is valid.' if is_completed

    'Sudoku is valid but incomplete.'
  end

  private

  def string_to_array
    puzzle = @puzzle_string.scan(/\d/).map(&:to_i)
    Array.new(9) { puzzle.shift(9) }
  end

  def valid_rows_columns_groups?(list)
    no_zero_list = list.reject(&:zero?)
    no_zero_list.to_set.subset?(VALID_NUMBERS) && no_zero_list.length == no_zero_list.to_set.length
  end
end
