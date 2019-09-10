module EquationControllerHelper
  def show_roots(equation)
    return if equation.errors.any? || action_name == :request_form

    return "Root is #{equation.result}" if equation.type == :linear
    
    if equation.type == :quadratic && equation.result.is_a?(Array)
      "Roots are  #{equation.result.first} and #{equation.result.last}"
    elsif equation.type == :quadratic && equation.result.is_a?(Float)
      "Root is #{equation.result} (Discriminant is equal to 0)."
    else
      "#{equation.result} (Discriminant is less than 0)."
    end
  end
end
