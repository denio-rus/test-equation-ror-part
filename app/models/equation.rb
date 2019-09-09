class Equation
  include ActiveModel::Validations
  
  attr_reader :a_param, :b_param, :c_param
  
  validates :a_param, :b_param, :c_param, presence: true, numericality: true

  def initialize(a_param = 0, b_param = 0, c_param = 0)
    @a_param = a_param
    @b_param = b_param
    @c_param = c_param
  end

  def solve
    Services::EquationSolver.call(params)
  end
end