require "rails_helper"

RSpec.describe Equation, type: :model do
  it { should validate_presence_of(:a_param) }
  it { should validate_presence_of(:type) }
  it { should validate_numericality_of(:a_param) }
  it { should validate_numericality_of(:b_param) }
  it { should validate_numericality_of(:c_param).allow_nil }
  it { should validate_inclusion_of(:type).in_array([:linear, :quadratic]) }

  let(:params) { { a_param: '1', b_param: '-8', c_param: '12', type: 'quadratic' } }
  let(:equation) { Equation.new }

  it 'solves equation and returns self with roots as result attribute' do
    expect(Services::ParamsParser).to receive(:call).and_call_original
    equation.solve(params)
  end
  
  context 'Services::EquationSolver valid result' do
    before do
      allow(Services::EquationSolver).to receive(:call).and_return({ 'result' => [6.0, 2.0] }) 
    end
    
    it 'sends self to Services::EquationSolver' do
      expect(Services::EquationSolver).to receive(:call).with(equation)
      equation.solve(params)
    end

    it 'takes roots from Services::EquationSolver and places them to result attr' do
      equation.solve(params)
      expect(equation.result).to eq [6.0, 2.0]
    end
  end

  context 'Services::EquationSolver error' do
    before do
      allow(Services::EquationSolver).to receive(:call).and_return({ 'error' => 'Some error' }) 
    end
    
    it 'takes error message from Services::EquationSolver and adds it to the errors of result' do
      equation.solve(params)
      expect(equation.errors.full_messages).to eq ['Result Some error']
    end
  end
end
