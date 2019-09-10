class EquationsController < ApplicationController
  def request_form
    @equation = Equation.new
  end

  def solve
    @equation = Equation.new.solve(params)
    if @equation.errors.any?
      render :request_form
    else
      render json: {
        type: @equation.type,
        a: @equation.a_param,
        b: @equation.a_param,
        c: @equation.a_param,
        result: @equation.result
      }
    end
  end

  def result
  end

  private

  def equation_params
    params.require(:equation).permit(:a_param, :b_param, :c_param, :type)
  end
end
