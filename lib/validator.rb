require_relative 'ValidatorClass'
class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    SudokuValidator.new(@puzzle_string).validate
  end
end
