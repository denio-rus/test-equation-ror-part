module EquationControllerHelper
  def show_roots(equation)
    return if equation.errros.any?

    return "Root is #{equation.result}" if equation.type == 'linear'
    
    if equation.type == 'quadratic' && equation.result.size > 1
      "Roots are  #{equation.result.first} and #{equation.result.last}"
    elsif equation.type == 'quadratic' && equation.result.size == 1
      "Root is #{equation.result} (Discriminant is equal to 0)."
    else
      "Hasn't roots (Discriminant is less than 0)."
    end
  end
end
