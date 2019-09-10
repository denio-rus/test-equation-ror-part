class Services::EquationSolver
  def initialize(equation)
    @equation = equation
  end

  def self.call(equation)
    self.new(equation).call
  end

  def call
    if @equation.type == :linear
      solve_linear_equation
    else
      QuadraticEquationSolver.call(@equation.a_param,
                                   @equation.b_param,
                                   @equation.c_param)
    end
  end

  private

  def solve_linear_equation
    -@equation.b_param / @equation.a_param
  end

  class QuadraticEquationSolver
    def initialize(a, b, c)
      @a = a
      @b = b
      @c = c
    end

    def self.call(a, b, c)
      self.new(a, b, c).call
    end

    def call
      solve
    end

    private
    
    def discriminant
     @discriminant ||= @b**2 - 4 * @a * @c
    end
     
    def solve
      return "No roots" if discriminant < 0
      
      if discriminant > 0
        x1 = (-@b + Math.sqrt(discriminant))/(2*@a)
        x2 = (-@b - Math.sqrt(discriminant))/(2*@a)
        [x1, x2]
      else discriminant == 0
        (-@b)/(2*@a)
      end
    end
  end
end