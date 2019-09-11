require 'rails_helper'

RSpec.describe Services::EquationSolver do
  let(:params) { { a: '1.6/2', b: '-8/2', c: '+12ce'} }

  it 'Parse params from string to numbers (float)' do 
    expect(Services::ParamsParser.call(params)).to eq({ a: 0.8, b: -4.0, c: "invalid parameter +12ce" })
  end
end