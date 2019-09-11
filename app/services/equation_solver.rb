class Services::EquationSolver
  def initialize(equation)
    @equation = equation
  end

  def self.call(equation)
    self.new(equation).call
  end

  def call
    res = HTTP.basic_auth(user: 'master', pass: "mathematics")
              .post('http://localhost:9292/solve_equation', body: @equation.to_json)
    JSON.parse(res.body)
  rescue HTTP::ConnectionError => e
    { 'error' => "Sorry, but our calculator is broken. Try it later." }
  end
end