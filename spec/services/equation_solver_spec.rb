require 'rails_helper'

RSpec.describe Services::EquationSolver do
  before(:all) { WebMock.enable! }
  after { WebMock.reset! }
  after(:all) { WebMock.disable! }

  let(:equation) { build(:equation) }

  it 'makes request to the remote service' do
    stub_request(:post, "http://localhost:9292/solve_equation").to_return(status: 200, body: "{\"a\":12.0}", headers: {})
    Services::EquationSolver.call(equation)
    expect(a_request(:post, 'http://localhost:9292/solve_equation').
    with(body: equation.to_json)).to have_been_made.once
  end

  it 'return error message if response status is server error' do 
    stub_request(:post, "http://localhost:9292/solve_equation").to_return(status: [500, "Internal Server Error"])
    expect(Services::EquationSolver.call(equation)).to eq Services::EquationSolver::ERROR_MESSAGE_HASH
  end
end
