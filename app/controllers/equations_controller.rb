class EquationsController < ApplicationController
  protect_from_forgery except: :solve
  
  def request_form
    @equation = Equation.new
  end

  def solve
    @equation = Equation.new.solve(equation_params)
  end

  private

  def equation_params
    params.require(:equation).permit(:a_param, :b_param, :c_param, :type)
  end
end
