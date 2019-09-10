class Equation < ApplicationRecord
  attr_reader :a_param, :b_param, :c_param, :type, :result
  
  validates :a_param, :b_param, :c_param, presence: true, numericality: true

  def solve(params)
    parse(params)
    @result = valid? ? Services::EquationSolver.call(self) : nil
  end

  private

  def parse(params)
    parsed_params = Services::ParamsParser.call(a: params[:a_param], 
                                                b: params[:b_param], 
                                                c: params[:c_param])
    @a_param = parsed_params[:a]
    @b_param = parsed_params[:b]
    @c_param = parsed_params[:c]
    @type = params[:type]
  end
end