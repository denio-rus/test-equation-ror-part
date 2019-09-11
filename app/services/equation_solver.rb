class Services::EquationSolver
  def initialize(equation)
    @equation = equation
  end

  def self.call(equation)
    self.new(equation).call
  end

  def call
    res = HTTP.post('http://localhost:9292/solve_equation',
                    body: @equation.to_json)
    JSON.parse(res.body)
  end
end