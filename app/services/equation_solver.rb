class Services::EquationSolver
  ERROR_MESSAGE_HASH = { 'error' => "Sorry, but our calculator is broken. Try it later." }.freeze

  def initialize(equation)
    @equation = equation
  end

  def self.call(equation)
    self.new(equation).call
  end

  def call
    res = HTTP.basic_auth(user: 'master', pass: 'mathematics')
              .post('http://localhost:9292/solve_equation', body: @equation.to_json)
    
    return ERROR_MESSAGE_HASH if res.status.server_error?

    JSON.parse(res.body)
  rescue HTTP::ConnectionError => e
    ERROR_MESSAGE_HASH
  end
end
